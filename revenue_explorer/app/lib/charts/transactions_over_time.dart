import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:revenue_explorer/http/transaction.http.dart';

class RevExTransactionsOverTimeChart extends StatelessWidget {
  final List<RevExTransaction> transactions;

  const RevExTransactionsOverTimeChart(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    final amountsByDate = transactions
        .groupListsBy(
          (tx) => DateFormat.yMd().format(DateTime.parse(tx.purchaseDate)),
        )
        .map(
          (key, value) => MapEntry<String, double>(
            key,
            value.fold(0, (previous, tx) => previous + tx.amount),
          ),
        );
    final orderedDates =
        transactions.map((tx) => DateTime.parse(tx.purchaseDate)).sorted();
    final allDates = List.generate(
      orderedDates.last.difference(orderedDates.first).inDays + 1,
      (index) => orderedDates.first.add(Duration(days: index)),
    ).map((dateTime) => DateFormat.yMd().format(dateTime)).toList();

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: LineChart(
        LineChartData(
          backgroundColor: Colors.transparent,
          lineBarsData: [
            LineChartBarData(
              spots: allDates
                  .mapIndexed(
                    (index, date) =>
                        FlSpot(index.toDouble(), amountsByDate[date] ?? 0),
                  )
                  .toList(),
            )
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (dataPoints) {
                return dataPoints.map((point) {
                  return LineTooltipItem("", const TextStyle(), children: [
                    TextSpan(text: allDates[point.x.toInt()]),
                    const TextSpan(text: '\n'),
                    TextSpan(
                        text: NumberFormat.simpleCurrency().format(point.y)),
                  ]);
                }).toList();
              },
            ),
          ),
          minY: 0,
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(allDates[value.toInt()]),
                  );
                },
                interval: allDates.length / 3,
                showTitles: true,
              ),
            ),
            topTitles: const AxisTitles(
              axisNameWidget: Text("Transaction volume over time"),
              axisNameSize: 48,
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
