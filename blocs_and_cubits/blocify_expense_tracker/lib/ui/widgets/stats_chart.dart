import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../data/models/transaction_model.dart';

class StatsChart extends StatelessWidget {
  final List<TransactionModel> transactions;

  const StatsChart({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    var totalIncome = 0.0;
    var totalExpense = 0.0;

    for (var txn in transactions) {
      if (txn.type == TransactionType.income) {
        totalIncome += txn.amount;
      } else {
        totalExpense += txn.amount;
      }
    }

    return SizedBox(
      height: 300,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: totalIncome,
              title: "Income\n\$${totalIncome.toStringAsFixed(2)}",
              color: Colors.green,
              radius: 70,
              titleStyle: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
            ),
            PieChartSectionData(
              value: totalExpense,
              title: "Expense\n\$${totalExpense.toStringAsFixed(2)}",
              color: Colors.red,
              radius: 70,
              titleStyle: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
