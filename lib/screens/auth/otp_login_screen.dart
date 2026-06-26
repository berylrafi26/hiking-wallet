import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import '../home/wallet_home_screen.dart';

class OtpLoginScreen extends StatefulWidget {
  final String uid;
  final String secret;

  const OtpLoginScreen({super.key, required this.uid, required this.secret});

  @override
  State<OtpLoginScreen> createState() => _OtpLoginScreenState();
}

class _OtpLoginScreenState extends State<OtpLoginScreen> {
  final otpController = TextEditingController();

  bool loading = false;

  Future<void> verifyOtp() async {
    setState(() {
      loading = true;
    });

    final currentOtp = OTP.generateTOTPCodeString(
      widget.secret,
      DateTime.now().millisecondsSinceEpoch,
      algorithm: Algorithm.SHA1,
      interval: 30,
      length: 6,
      isGoogle: true,
    );

    if (otpController.text.trim() == currentOtp) {
      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => WalletHomeScreen(uid: widget.uid)),
        (route) => false,
      );
    }
  }
}
