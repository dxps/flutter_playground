import 'dart:math';

import 'package:flutter/material.dart';

import '../../data/models/transaction_model.dart';
import '../../utils/category_list.dart';
import '../../utils/constants.dart';
import '../widgets/summary_card.dart';
import '../widgets/transaction_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(defaultSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SummaryCard(label: "Total balance", amount: "\$8000", icon: Icons.account_balance, color: primaryDark),
            SizedBox(height: defaultSpacing),
            Row(
              children: [
                Expanded(
                  child: SummaryCard(
                    label: "Income",
                    amount: "\$10000",
                    icon: Icons.arrow_upward_rounded,
                    color: secondaryDark,
                  ),
                ),
                SizedBox(width: defaultSpacing),
                Expanded(
                  child: SummaryCard(
                    label: "Expense",
                    amount: "\$2000",
                    icon: Icons.arrow_downward_rounded,
                    color: accentColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: defaultSpacing * 2),
            Text(
              "Recent transactions",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: defaultSpacing),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return TransactionCard(
                  transaction: TransactionModel(
                    id: DateTime.now().microsecondsSinceEpoch,
                    amount: Random().nextInt(1000) + 50,
                    category: index % 2 == 0 ? incomeCategoryList[index] : expenseCategoryList[index],
                    type: index % 2 == 0 ? TransactionType.income : TransactionType.expense,
                    date: DateTime.now().subtract(Duration(days: Random().nextInt(90).toInt())),
                  ),
                  onDelete: () {},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
