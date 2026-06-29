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
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('transactions')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error : ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("Tidak ada data"));
          }

          final docs = snapshot.data!.docs.where((doc) {
            final data = doc.data() as Map<String, dynamic>;

            return data['uid'] == uid || data['userId'] == uid;
          }).toList();

          docs.sort((a, b) {
            final ta =
                (a['createdAt'] as Timestamp?)?.millisecondsSinceEpoch ?? 0;

            final tb =
                (b['createdAt'] as Timestamp?)?.millisecondsSinceEpoch ?? 0;

            return tb.compareTo(ta);
          });

          if (docs.isEmpty) {
            return const Center(child: Text("Belum ada transaksi"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;

              final String type = data['type']?.toString() ?? 'purchase';

              final bool isTopup = type == "topup";

              final int amount = (data['amount'] ?? data['total'] ?? 0) as int;

              final String status = data['status']?.toString() ?? "-";

              final Timestamp? ts = data['createdAt'] as Timestamp?;

              final DateTime? time = ts?.toDate();

              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
                      const SizedBox(height: 4),
                      Text(
                        time == null
                            ? "-"
                            : "${time.day}/${time.month}/${time.year} "
                                  "${time.hour}:${time.minute.toString().padLeft(2, '0')}",
                      ),
                      const SizedBox(height: 4),
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
