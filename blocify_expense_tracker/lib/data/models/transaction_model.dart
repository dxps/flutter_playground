import 'category_model.dart';

enum TransactionType {
  expense,
  income,
}

class TransactionModel {
  final int id;
  final double amount;
  final CategoryModel category;
  final TransactionType type;
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.category,
    required this.type,
    required this.date,
  });
}
