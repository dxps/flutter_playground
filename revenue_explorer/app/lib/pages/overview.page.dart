import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revenue_explorer/http/transaction.http.dart';
import 'package:revenue_explorer/main.dart';
import 'package:revenue_explorer/pages/detail.page.dart';
import 'package:revenue_explorer/transactions.state.dart';
import 'package:revenue_explorer/widgets/future_handler.dart';
import 'package:revenue_explorer/widgets/sort_icon.dart';

class RevExOverviewPage extends StatefulWidget {
  const RevExOverviewPage({super.key});

  @override
  State<RevExOverviewPage> createState() => _RevExOverviewPageState();
}

class _RevExOverviewPageState extends State<RevExOverviewPage> {
  @override
  void initState() {
    super.initState();
    context.read<RevExTransactionsState>().loadTransactions(context);
  }

  @override
  Widget build(BuildContext context) {
    return RevExScaffold(
      title: 'Transactions',
      body: Consumer<RevExTransactionsState>(builder: (context, state, _) {
        return RevExFutureHandler<List<RevExTransaction>>(
          future: state.transactions,
          errorText: 'Error: Cannot get transaction data.',
          childBuilder: (_, transactions) => _TransactionTable(transactions),
        );
      }),
    );
  }
}

class _TransactionDataSource extends DataTableSource {
  final BuildContext context;
  List<RevExTransaction> transactions;
  int sortIndex = 2;
  bool sortAscending = false;

  _TransactionDataSource(this.transactions, this.context) {
    getColumns()[sortIndex].onSort?.call(sortIndex, sortAscending);
  }

  void _viewDetail(String columnName, String value) {
    context.pushNamed('detail', params: <String, String>{
      'columnName': columnName,
      'columnValue': value
    });
  }

  List<DataColumn> getColumns() {
    return [
      DataColumn(
        label: _TappableHeader(
          "Purchaser",
          isSorting: sortIndex == 0,
          isAscending: sortAscending,
        ),
        onSort:
            handleSort((a, b) => a.purchaserName.compareTo(b.purchaserName)),
      ),
      DataColumn(
        label: _TappableHeader(
          "Amount",
          isSorting: sortIndex == 1,
          isAscending: sortAscending,
        ),
        numeric: true,
        onSort: handleSort((a, b) => Comparable.compare(a.amount, b.amount)),
      ),
      DataColumn(
        label: _TappableHeader(
          "Date",
          isSorting: sortIndex == 2,
          isAscending: sortAscending,
        ),
        onSort: handleSort((a, b) => a.purchaseDate.compareTo(b.purchaseDate)),
      ),
      DataColumn(
        label: _TappableHeader(
          "Product Code",
          isSorting: sortIndex == 3,
          isAscending: sortAscending,
        ),
        onSort: handleSort((a, b) => a.productCode.compareTo(b.productCode)),
      ),
    ];
  }

  @override
  DataRow? getRow(int index) {
    final tx = transactions[index];
    final formattedDate =
        DateFormat.yMd().format(DateTime.parse(tx.purchaseDate));
    return DataRow(cells: [
      DataCell(
        _TappableCell(
          tx.purchaserName,
          isSorting: sortIndex == 0,
        ),
        onTap: () => _viewDetail(
          RevExDetailColumn.purchaserName,
          tx.purchaserName,
        ),
      ),
      DataCell(_TappableCell(
        tx.amount.toString(),
        isTappable: false,
        isSorting: sortIndex == 1,
      )),
      DataCell(
        _TappableCell(
          formattedDate,
          isSorting: sortIndex == 2,
        ),
        onTap: () => _viewDetail(
          RevExDetailColumn.purchaseDate,
          tx.purchaseDate,
        ),
      ),
      DataCell(
        _TappableCell(
          tx.productCode,
          isSorting: sortIndex == 3,
        ),
        onTap: () => _viewDetail(
          RevExDetailColumn.productCode,
          tx.productCode,
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  Function(int, bool) handleSort(
      int Function(RevExTransaction a, RevExTransaction b) compare) {
    return (ix, ascending) {
      if (ix == sortIndex) {
        sortAscending = !sortAscending;
      } else {
        sortAscending = ascending;
      }

      sortIndex = ix;

      transactions.sort(compare);
      if (!sortAscending) {
        transactions = transactions.reversed.toList();
      }
      notifyListeners();
    };
  }

  @override
  int get rowCount => transactions.length;

  @override
  int get selectedRowCount => 0;
}

class _TransactionTable extends StatefulWidget {
  final List<RevExTransaction> transactions;

  const _TransactionTable(this.transactions);

  @override
  State<_TransactionTable> createState() => _TransactionTableState();
}

class _TransactionTableState extends State<_TransactionTable> {
  late _TransactionDataSource tableData;

  @override
  void initState() {
    super.initState();
    tableData = _TransactionDataSource(widget.transactions, context);
    tableData.addListener(() => mounted ? setState(() {}) : null);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PaginatedDataTable(
        columns: tableData.getColumns(),
        source: tableData,
      ),
    );
  }
}

class _TappableCell extends StatelessWidget {
  final String contents;
  final bool isTappable;
  final bool isSorting;

  const _TappableCell(this.contents,
      {this.isTappable = true, required this.isSorting});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: isTappable ? MainAxisSize.max : MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              color: Colors.black,
              fontWeight: isSorting ? FontWeight.bold : FontWeight.normal,
            ),
            child: Text(contents),
          ),
        ),
        if (isTappable) const Icon(Icons.bar_chart),
      ],
    );
  }
}

class _TappableHeader extends StatelessWidget {
  final String headerText;
  final bool isSorting;
  final bool isAscending;

  const _TappableHeader(
    this.headerText, {
    required this.isSorting,
    required this.isAscending,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              color: Colors.black,
              fontWeight: isSorting ? FontWeight.bold : FontWeight.normal,
            ),
            child: Text(headerText),
          ),
        ),
        if (isSorting)
          RevExSortIcon(
            isAscending: isAscending,
          )
      ],
    );
  }
}
