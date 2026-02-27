import 'package:flutter/material.dart';
import 'package:revenue_explorer/http/http.dart';
import 'package:revenue_explorer/http/transaction.http.dart';

class RevExTransactionsState extends ChangeNotifier {
  Future<List<RevExTransaction>>? transactions;

  Future<void> loadTransactions(
    BuildContext context, {
    bool forceRefresh = false,
  }) async {
    if (transactions == null || forceRefresh) {
      transactions = revExGetTransactions.authorize(context);
      Future(() => notifyListeners());
    }
  }
}
