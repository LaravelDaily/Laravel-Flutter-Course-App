class Transaction {
  int id;
  int categoryId;
  String categoryName;
  String description;
  String amount;
  String transactionDate;
  String createdAt;

  Transaction({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.description,
    required this.amount,
    required this.transactionDate,
    required this.createdAt
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      description: json['description'],
      amount: json['amount'],
      transactionDate: json['transaction_date'],
      createdAt: json['created_at'],
    );
  }
}