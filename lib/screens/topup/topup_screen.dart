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

  final List<int> quickAmounts = [20000, 50000, 100000, 200000];

  Future<void> topup() async {
    final amount = int.tryParse(amountController.text);

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Masukkan nominal yang valid"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await WalletService().topUp(uid: widget.uid, amount: amount);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Isi saldo berhasil! Siap untuk petualangan baru."),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Warna tema Hiking Hijau
    final primaryGreen = Colors.green.shade800;
    final accentGreen = Colors.green.shade50;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          "Isi Saldo Petualang",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: primaryGreen,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Seksi Atas: Info Grafis / Banner Kecil
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: accentGreen,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green.shade200, width: 1),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.landscape_rounded,
                      size: 50,
                      color: primaryGreen,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Amankan Logistikmu",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryGreen,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Top up saldomu untuk mempermudah transaksi sewa alat dan tiket jalur pendakian.",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Label Input
              Text(
                "Masukkan Nominal Top Up",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 12),

              // Input TextField
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  prefixText: "Rp ",
                  prefixStyle: TextStyle(
                    color: primaryGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  hintText: "0",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 16,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: primaryGreen, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Pilihan Nominal Cepat
              Text(
                "Pilih Nominal Instan",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: quickAmounts.length,
                itemBuilder: (context, index) {
                  final amount = quickAmounts[index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        amountController.text = amount.toString();
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: amountController.text == amount.toString()
                              ? primaryGreen
                              : Colors.grey.shade300,
                          width: amountController.text == amount.toString()
                              ? 2
                              : 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Rp ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: amountController.text == amount.toString()
                              ? primaryGreen
                              : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),

              // Tombol Konfirmasi Top Up
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: loading ? null : topup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                  ),
                  child: loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Konfirmasi & Bayar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
