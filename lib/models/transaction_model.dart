class TransactionModel {
  final String id;
  final String userId;
  final String type;
  final int amount;
  final String status;
  final String description;
  final DateTime? createdAt;

  TransactionModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.amount,
    required this.status,
    required this.description,
    this.createdAt,
  });

  factory TransactionModel.fromMap(String id, Map<String, dynamic> json) {
    return TransactionModel(
      id: id,
      userId: json['userId'] ?? '',
      type: json['type'] ?? '',
      amount: json['amount'] ?? 0,
      status: json['status'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['createdAt']?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'type': type,
      'amount': amount,
      'status': status,
      'description': description,
      'createdAt': createdAt,
    };
  }
}
