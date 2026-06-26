import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../services/wallet_service.dart';
import 'google_authenticator_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    try {
      final user = await AuthService().login(
        email: emailController.text,
        password: passwordController.text,
      );

      final secret = await WalletService().prepareTotp(user.uid);

      if (!mounted) return;

    
  }
}
