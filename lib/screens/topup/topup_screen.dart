import 'package:flutter/material.dart';

import '../../services/wallet_service.dart';

class TopupScreen extends StatefulWidget {
  final String uid;

  const TopupScreen({super.key, required this.uid});

  @override
  State<TopupScreen> createState() => _TopupScreenState();
}

class _TopupScreenState extends State<TopupScreen> {
  final amountController = TextEditingController();

  bool loading = false;

  Future<void> topup() async {
    final amount = int.tryParse(amountController.text);

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Masukkan nominal yang valid")),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await WalletService().topUp(uid: widget.uid, amount: amount);

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Top Up berhasil")));

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    setState(() {
      loading = false;
    });
  }
}
