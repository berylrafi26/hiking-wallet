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
}
