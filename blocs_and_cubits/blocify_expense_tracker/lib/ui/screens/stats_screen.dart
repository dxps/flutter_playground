import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/stats_bloc/stats_bloc.dart';
import '../../blocs/stats_bloc/stats_events.dart';
import '../../blocs/stats_bloc/stats_state.dart';
import '../../utils/constants.dart';
import '../../utils/show_snackbar.dart';
import '../widgets/message_widget.dart';
import '../widgets/month_picker_button.dart';
import '../widgets/stats_chart.dart';
import '../widgets/transaction_card.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  DateTime? selectedDate;

  @override
  void initState() {
    context.read<StatsBloc>().add(const StatsLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StatsBloc, StatsState>(
      listener: (context, state) {
        if (state is StatsDeletedTransactionState) {
          context.read<StatsBloc>().add(const StatsLoadEvent());
          showSnackbar(context, state.message);
        }
      },
      builder: (context, state) {
        switch (state) {
          case StatsLoadingState():
            return const Center(child: CircularProgressIndicator());
          case StatsLoadedState():
            if (state.transactions.isEmpty) {
              return MessageWidget(icon: Icons.error_outline_rounded, message: "No monthy stats available.");
            }
            if (state.transactions.isNotEmpty) {
              selectedDate = state.transactions.first.date;
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(defaultSpacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MonthPickerButton(
                    date: selectedDate ?? DateTime.now(),
                    months: state.dates,
                    onMonthSelected: (date) {
                      selectedDate = date;
                      context.read<StatsBloc>().add(StatsDateChangedEvent(date: date));
                    },
                  ),
                  const SizedBox(height: defaultSpacing),
                  state.transactions.isNotEmpty
                      ? Column(
                          children: [
                            StatsChart(transactions: state.transactions),
                            const SizedBox(height: defaultSpacing),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.transactions.length,
                              itemBuilder: (context, index) {
                                return TransactionCard(
                                  transaction: state.transactions[index],
                                  onDelete: () {
                                    context.read<StatsBloc>().add(
                                      StatsDeleteTransactionEvent(state.transactions[index].id),
                                    );
                                    if (state.transactions.length == 1) {
                                      selectedDate = null;
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        )
                      : const SizedBox(
                          height: 400,
                          child: MessageWidget(
                            icon: Icons.playlist_remove_outlined,
                            message: "No stats available for this month",
                          ),
                        ),
                ],
              ),
            );
          case StatsErrorState():
            return MessageWidget(icon: Icons.error_outline_rounded, message: state.errorMessage);
          case StatsDeletedTransactionState():
            // TODO: tbd
            return MessageWidget(icon: Icons.error_outline_rounded, message: "Something went wrong!");
        }
      },
    );
  }
}
