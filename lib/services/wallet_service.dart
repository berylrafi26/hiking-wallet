import 'package:cloud_firestore/cloud_firestore.dart';
import 'totp_service.dart';

class WalletService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
