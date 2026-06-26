import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../services/wallet_service.dart';
import 'otp_login_screen.dart';

class GoogleAuthenticatorScreen extends StatelessWidget {
  final String uid;
  final String email;
  final String secret;
  final bool isFirstSetup;

  const GoogleAuthenticatorScreen({
    super.key,
    required this.uid,
    required this.email,
    required this.secret,
    required this.isFirstSetup,
  });

  @override
  Widget build(BuildContext context) {
    final otpUri =
        "otpauth://totp/HikingWallet:$email"
        "?secret=$secret"
        "&issuer=HikingWallet";

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Google Authenticator",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            if (isFirstSetup) ...[
              const Text(
                "Scan QR Code menggunakan Google Authenticator",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),

              const SizedBox(height: 25),

              QrImageView(data: otpUri, size: 250),

              const SizedBox(height: 20),

              SelectableText(
                secret,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await WalletService().enableTotp(uid);

                    if (!context.mounted) return;

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            OtpLoginScreen(uid: uid, secret: secret),
                      ),
                    );
                  },
                  child: const Text("Saya Sudah Scan"),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
