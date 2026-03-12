import 'package:blocify_expense_tracker/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/home/home_cubit.dart';
import '../../cubits/home_state.dart';
import '../../utils/constants.dart';
import '../widgets/message_widget.dart';
import '../widgets/summary_card.dart';
import '../widgets/transaction_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().loadTransactions();

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeDeletedTransactionState || state is HomeDeletedTransactionState) {
          context.read<HomeCubit>().loadTransactions();
          showSnackbar(context, state.message);
        }
      },
      builder: (context, state) {
        switch (state) {
          case HomeLoadingState():
            return const Center(child: CircularProgressIndicator());

          case HomeErrorState():
            return MessageWidget(icon: Icons.error_outline_rounded, message: state.errorMessage);

          case HomeLoadedState():
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(defaultSpacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SummaryCard(
                      label: "Total balance",
                      amount: "\$${state.summary.totalBalance}",
                      icon: Icons.account_balance,
                      color: primaryDark,
                    ),
                    SizedBox(height: defaultSpacing),
                    Row(
                      children: [
                        Expanded(
                          child: SummaryCard(
                            label: "Income",
                            amount: "\$${state.summary.totalIncome}",
                            icon: Icons.arrow_upward_rounded,
                            color: secondaryDark,
                          ),
                        ),
                        SizedBox(width: defaultSpacing),
                        Expanded(
                          child: SummaryCard(
                            label: "Expense",
                            amount: "\$${state.summary.totalExpenses}",
                            icon: Icons.arrow_downward_rounded,
                            color: accentColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: defaultSpacing * 2),
                    Text(
                      "Recent Transactions",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: defaultSpacing),
                    state.transactions.isEmpty
                        ? const SizedBox(
                            height: 250,
                            child: MessageWidget(icon: Icons.money_off_outlined, message: "No transactions exist"),
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.transactions.length,
                            itemBuilder: (context, index) {
                              return TransactionCard(
                                transaction: state.transactions[index],
                                onDelete: () {
                                  context.read<HomeCubit>().deleteTransaction(state.transactions[index].id);
                                },
                              );
                            },
                          ),
                  ],
                ),
              ),
            );

          default:
            return MessageWidget(icon: Icons.error_outline_rounded, message: "Something went wrong.");
        }
      },
    );
  }
}
