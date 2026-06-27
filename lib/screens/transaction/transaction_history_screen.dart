import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/wallet_service.dart';

class TransactionHistoryScreen extends StatelessWidget {
  final String uid;

  const TransactionHistoryScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Riwayat Transaksi",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: WalletService().transactionStream(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Belum ada transaksi"));
          }

          final transactions = snapshot.data!.docs;
        },
      ),
    );
  }
}
