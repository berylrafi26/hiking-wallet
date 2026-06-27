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

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final data = transactions[index].data();

              final amount = data['amount'];

              final type = data['type'];

              final status = data['status'];

              final timestamp = data['createdAt'];

              String date = "-";

              if (timestamp != null) {
                final dt = (timestamp as Timestamp).toDate();

                date =
                    "${dt.day}/${dt.month}/${dt.year}  ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}";
              }

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: type == "topup"
                        ? Colors.green
                        : Colors.orange,
                    child: Icon(
                      type == "topup" ? Icons.add : Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(type == "topup" ? "Top Up" : "Pembayaran"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
