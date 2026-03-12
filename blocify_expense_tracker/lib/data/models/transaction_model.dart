import 'package:hive/hive.dart';

import 'category_model.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
enum TransactionType {
  @HiveField(0)
  expense,
  @HiveField(1)
  income,
}

@HiveType(typeId: 1)
class TransactionModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final CategoryModel category;
  @HiveField(3)
  final TransactionType type;
  @HiveField(4)
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.category,
    required this.type,
    required this.date,
  });

  // (i) Explicitly implementing `==` and `hashCode` methods.
  // Otherwise, if using `with EquatableMixin` we have this warning:
  // "This class (or a class that this class inherits from) is marked as '@immutable',
  // but one or more of its instance fields aren't final: HiveObjectMixin._box"

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionModel &&
        other.id == id &&
        other.amount == amount &&
        other.category == category &&
        other.type == type &&
        other.date == date;
  }

  @override
  int get hashCode => Object.hash(id, amount, category, type, date);
}
