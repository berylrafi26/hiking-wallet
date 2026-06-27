import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('transactions').get(),

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs.where((doc) {
            final data = doc.data() as Map<String, dynamic>;

            return data['uid'] == uid || data['userId'] == uid;
          }).toList();

          docs.sort((a, b) {
            final ta = (a['createdAt'] as Timestamp).millisecondsSinceEpoch;
            final tb = (b['createdAt'] as Timestamp).millisecondsSinceEpoch;

            return tb.compareTo(ta);
          });

          if (docs.isEmpty) {
            return const Center(child: Text("Belum ada transaksi"));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;

              final amount = data['amount'] ?? 0;

              final status = data['status'] ?? "-";

              final bool isTopup = data['type'] == "topup";

              final time = (data['createdAt'] as Timestamp).toDate();

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isTopup ? Colors.green : Colors.orange,
                    child: Icon(
                      isTopup
                          ? Icons.account_balance_wallet
                          : Icons.shopping_bag,
                      color: Colors.white,
                    ),
                  ),

                  title: Text(
                    isTopup ? "Top Up Saldo" : "Pembayaran Hiking",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${time.day}/${time.month}/${time.year} ${time.hour}:${time.minute.toString().padLeft(2, '0')}",
                      ),
                      Text(status),
                    ],
                  ),

                  trailing: Text(
                    "${isTopup ? '+' : '-'} Rp $amount",
                    style: TextStyle(
                      color: isTopup ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
