import 'package:blocify_expense_tracker/data/models/transaction_model.dart';
import 'package:blocify_expense_tracker/utils/constants.dart';
import 'package:blocify_expense_tracker/utils/format_date.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback onDelete;

  const TransactionCard({super.key, required this.transaction, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(defaultRadius), color: Colors.white),
        padding: const EdgeInsets.all(defaultSpacing),
        child: Row(
          children: [
            Icon(transaction.category.icon, size: defaultIconSize, color: transaction.category.color),
            const SizedBox(width: defaultSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.category.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: defaultFontSize),
                  ),
                  const SizedBox(height: defaultSpacing / 4),
                  Text(
                    formatDate(transaction.date),
                    style: TextStyle(color: Colors.grey, fontSize: defaultFontSize - 4.0),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${transaction.type == TransactionType.income ? "+" : "-"}\$${transaction.amount.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: transaction.type == TransactionType.income ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: defaultFontSize,
                  ),
                ),
                const SizedBox(height: defaultSpacing / 4),
                IconButton(icon: const Icon(Icons.delete), onPressed: onDelete, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
