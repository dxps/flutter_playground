import 'package:blocify_expense_tracker/data/models/transaction_model.dart';
import 'package:hive/hive.dart';

class TransactionRepo {
  late final Box<TransactionModel> _transactionBox;

  TransactionRepo(Box<TransactionModel> transactionBox) {
    _transactionBox = transactionBox;
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      if (transaction.amount > 0) {
        await _transactionBox.put(transaction.id, transaction);
      } else {
        throw Exception("Amount must be greater than 0.");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
