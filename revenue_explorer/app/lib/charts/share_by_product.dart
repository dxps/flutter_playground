import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../http/transaction.http.dart';

class RevExShareByProductChart extends StatelessWidget {
  final List<RevExTransaction> transactions;

  const RevExShareByProductChart(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    final amountsByProduct = transactions
        .groupListsBy((tx) => tx.productCode)
        .map((key, value) => MapEntry<String, double>(
            key, value.fold(0, (previous, tx) => previous + tx.amount)));
    final orderedProducts =
        amountsByProduct.entries.sortedBy<num>((entry) => entry.value).reversed;

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text("Transaction volume by product code"),
        ),
        Expanded(
          child: PieChart(
            PieChartData(
              borderData: FlBorderData(
                show: false,
              ),
              sections: orderedProducts
                  .map(
                    (entry) => PieChartSectionData(
                      value: entry.value,
                      title:
                          '${entry.key}\n${NumberFormat.compactSimpleCurrency().format(entry.value)}',
                      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                  .toList(),
              startDegreeOffset: -90,
            ),
          ),
        ),
      ],
    );
  }
}
