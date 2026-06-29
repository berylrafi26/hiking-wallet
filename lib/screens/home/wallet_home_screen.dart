import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../services/wallet_service.dart';

import '../auth/login_screen.dart';
import '../topup/topup_screen.dart';
import '../transaction/transaction_history_screen.dart';

class WalletHomeScreen extends StatelessWidget {
  final String uid;

  const WalletHomeScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    // Tema warna hijau alam / hiking
    const primaryGreen = Color(0xFF1B4D3E);
    const accentGreen = Color(0xFF2E7D32);
    const lightBg = Color(0xFFF4F7F5);

    return Scaffold(
      backgroundColor: lightBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: primaryGreen,
        title: const Text(
          "Hiking Wallet",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.logout, color: Colors.redAccent),
              onPressed: () async {
                await AuthService().logout();
                if (!context.mounted) return;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (_) => false,
                );
              },
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: WalletService().walletStream(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: primaryGreen),
            );
          }

          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.data() == null) {
            return const Center(child: Text("Gagal memuat data dompet."));
          }

          final data = snapshot.data!.data()!;
          // Default values jika field null di DB
          final String email = data['email'] ?? 'Pendaki Misterius';
          final dynamic balance = data['balance'] ?? 0;

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            children: [
              // Seksi Profil Singkat
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: primaryGreen.withOpacity(0.1),
                    child: const Icon(
                      Icons.person,
                      color: primaryGreen,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Halo, Petualang!",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          email,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Kartu Saldo Premium (Gradient + Elemen Estetik Gunung)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [primaryGreen, accentGreen],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryGreen.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(
                        0,
                        8,
                      ), // <-- Ubah Alignment menjadi Offset
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Ikon Gunung Samar di Background Kartu
                    Positioned(
                      right: -10,
                      bottom: -20,
                      child: Icon(
                        Icons.landscape,
                        size: 130,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total Saldo Anda",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            Icon(
                              Icons.monetization_on,
                              color: Colors.amber[400],
                              size: 24,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Rp $balance",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          "Siap untuk mendaki kembali?",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),

              // Bagian Menu / Aksi Cepat
              const Text(
                "Menu Dompet",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryGreen,
                ),
              ),
              const SizedBox(height: 16),

              // Layout Aksi berbentuk Grid Horizontal yang bersih
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      context: context,
                      icon: Icons.add_card_rounded,
                      label: "Top Up",
                      color: primaryGreen,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TopupScreen(uid: uid),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildActionButton(
                      context: context,
                      icon: Icons.history_rounded,
                      label: "Riwayat",
                      color: accentGreen,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TransactionHistoryScreen(uid: uid),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  // Helper Widget untuk membuat tombol aksi yang rapi
  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
