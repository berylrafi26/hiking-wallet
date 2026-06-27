class WalletModel {
  final String uid;
  final String email;
  final int balance;

  WalletModel({required this.uid, required this.email, required this.balance});

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      uid: map['uid'],
      email: map['email'],
      balance: map['balance'],
    );
  }
}
