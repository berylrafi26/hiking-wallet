import 'package:cloud_firestore/cloud_firestore.dart';
import 'totp_service.dart';

class WalletService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<DocumentSnapshot<Map<String, dynamic>>> walletStream(String uid) {
    return _firestore.collection('wallets').doc(uid).snapshots();
  }

  Future<bool> isTotpEnabled(String uid) async {
    final doc = await _firestore.collection('wallets').doc(uid).get();

    if (!doc.exists) return false;

    final data = doc.data()!;

    return data['totpEnabled'] == true;
  }

  Future<void> enableTotp(String uid) async {
    await _firestore.collection('wallets').doc(uid).update({
      'totpEnabled': true,
    });
  }

  Future<String> prepareTotp(String uid) async {
    final doc = await _firestore.collection('wallets').doc(uid).get();

    if (!doc.exists) {
      throw Exception("Wallet tidak ditemukan");
    }

    final data = doc.data()!;

    if (data['totpSecret'] != null &&
        data['totpSecret'].toString().isNotEmpty) {
      return data['totpSecret'];
    }

    final secret = TotpService.generateSecret();

    await _firestore.collection('wallets').doc(uid).update({
      'totpSecret': secret,
    });

    return secret;
  }

  Future<void> topUp({required String uid, required int amount}) async {
    final walletRef = _firestore.collection('wallets').doc(uid);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(walletRef);

      if (!snapshot.exists) {
        throw Exception("Wallet tidak ditemukan");
      }

      final currentBalance = snapshot['balance'];

      transaction.update(walletRef, {'balance': currentBalance + amount});

      transaction.set(_firestore.collection('transactions').doc(), {
        'uid': uid,
        'type': 'topup',
        'amount': amount,
        'status': 'success',
        'createdAt': FieldValue.serverTimestamp(),
      });
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> transactionStream(String uid) {
    return _firestore
        .collection('transactions')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }
}
