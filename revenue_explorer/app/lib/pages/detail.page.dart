import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revenue_explorer/charts/share_by_product.dart';
import 'package:revenue_explorer/charts/share_by_purchaser.dart';
import 'package:revenue_explorer/charts/transactions_over_time.dart';
import 'package:revenue_explorer/http/transaction.http.dart';
import 'package:revenue_explorer/main.dart';
import 'package:revenue_explorer/widgets/future_handler.dart';

import '../transactions.state.dart';

class RevExDetailColumn {
  static const String purchaserName = 'purchaserName';
  static const String purchaseDate = 'purchaseDate';
  static const String productCode = 'productCode';
}

class RevExDetailPage extends StatefulWidget {
  final String filterColumnName;
  final String filterColumnValue;

  const RevExDetailPage({
    super.key,
    required this.filterColumnName,
    required this.filterColumnValue,
  });

  @override
  State<RevExDetailPage> createState() => _RevExDetailPageState();
}

class _RevExDetailPageState extends State<RevExDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<RevExTransactionsState>().loadTransactions(context);
  }

  @override
  Widget build(BuildContext context) {
    return RevExScaffold(
      title: widget.filterColumnName == RevExDetailColumn.purchaseDate
          ? DateFormat.yMd().format(DateTime.parse(widget.filterColumnValue))
          : widget.filterColumnValue,
      body: Consumer<RevExTransactionsState>(builder: (context, state, _) {
        return RevExFutureHandler(
            future: state.transactions,
            errorText: 'Error: Cannot get transaction data.',
            childBuilder: (_, transactions) {
              final filtered = _filterTransactions(
                transactions,
                onColumn: widget.filterColumnName,
                byValue: widget.filterColumnValue,
              );

              final List<Widget> chartsToShow = {
                    RevExDetailColumn.purchaserName: <Widget>[
                      RevExTransactionsOverTimeChart(filtered),
                      RevExShareByProductChart(transactions),
                    ],
                    RevExDetailColumn.purchaseDate: <Widget>[
                      RevExShareByPurchaserChart(transactions),
                      RevExShareByProductChart(transactions),
                    ],
                    RevExDetailColumn.productCode: <Widget>[
                      RevExTransactionsOverTimeChart(transactions),
                      RevExShareByPurchaserChart(transactions),
                    ]
                  }[widget.filterColumnName] ??
                  const [SizedBox.shrink(), SizedBox.shrink()];

              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: chartsToShow.first,
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: chartsToShow.last,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 24),
                  ),
                ],
              );
            });
      }),
    );
  }

  List<RevExTransaction> _filterTransactions(
    List<RevExTransaction> transactions, {
    required String onColumn,
    required String byValue,
  }) {
    switch (onColumn) {
      case RevExDetailColumn.purchaserName:
        return transactions.where((tx) => tx.purchaserName == byValue).toList();
      case RevExDetailColumn.purchaseDate:
        String dateOnly(String dateString) =>
            DateFormat.yMd().format(DateTime.parse(dateString));
        return transactions
            .where((tx) => dateOnly(tx.purchaseDate) == dateOnly(byValue))
            .toList();
      case RevExDetailColumn.productCode:
        return transactions.where((tx) => tx.productCode == byValue).toList();
    }

    return transactions;
  }
}
