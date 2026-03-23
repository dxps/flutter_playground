import 'package:hive/hive.dart';

import '../models/transaction_model.dart';

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

  Future<void> deleteTransaction(int id) async {
    await _transactionBox.delete(id);
  }

  List<TransactionModel> getAllTransactions() {
    return _transactionBox.values.toList();
  }

  List<TransactionModel> getLatestTransactions({int count = 10}) {
    final allTxns = getAllTransactions();
    allTxns.sort((a, b) => b.date.compareTo(a.date));
    final latestTxns = allTxns.take(count).toList();
    return latestTxns;
  }

  double getTotalIncome() {
    final allTxns = getAllTransactions();
    return allTxns.where((txn) => txn.type == TransactionType.income).fold(0.0, (sum, txn) => sum + txn.amount);
  }

  double getTotalExpenses() {
    final allTxns = getAllTransactions();
    return allTxns.where((txn) => txn.type == TransactionType.expense).fold(0.0, (sum, txn) => sum + txn.amount);
  }

  double getTotalBalance() {
    double totalIncome = getTotalIncome();
    double totalExpenses = getTotalExpenses();
    return totalIncome - totalExpenses;
  }

  Set<DateTime> getUniqueTransactionMonths() {
    final txns = getAllTransactions();
    final uniqueMonths = <DateTime>{};
    for (var txn in txns) {
      final monthYear = DateTime(txn.date.year, txn.date.month);
      uniqueMonths.add(monthYear);
    }
    return uniqueMonths;
  }

  List<TransactionModel> getStatsTransactions({DateTime? date}) {
    if (date == null) {
      final uniqueMonths = getUniqueTransactionMonths();
      if (uniqueMonths.isEmpty) {
        return [];
      }
      final latestMonth = uniqueMonths.reduce((a, b) => a.isAfter(b) ? a : b);
      date = latestMonth;
    }
    final allTxns = getAllTransactions();
    final statsTxns = allTxns
        .where(
          (txn) => txn.date.year == date!.year && txn.date.month == date.month,
        )
        .toList();
    statsTxns.sort((a, b) => b.date.compareTo(a.date));
    return statsTxns;
  }
}
