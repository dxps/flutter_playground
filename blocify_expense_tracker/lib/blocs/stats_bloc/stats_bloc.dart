import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/transaction_repo.dart';
import 'stats_events.dart';
import 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  TransactionRepo transactionRepo;

  StatsBloc(this.transactionRepo) : super(StatsLoadingState()) {
    on<StatsLoadEvent>((event, emit) async {
      try {
        emit(StatsLoadingState());
        final txns = transactionRepo.getStatsTransactions(date: event.date);
        final statsDates = transactionRepo.getUniqueTransactionMonths();
        emit(StatsLoadedState(transactions: txns, dates: statsDates));
      } catch (e) {
        emit(StatsErrorState(e.toString()));
      }
    });

    on<StatsDateChangedEvent>((event, emit) async {
      try {
        emit(StatsLoadingState());
        final txns = transactionRepo.getStatsTransactions(date: event.date);
        final statsDates = transactionRepo.getUniqueTransactionMonths();
        emit(StatsLoadedState(transactions: txns, dates: statsDates));
      } catch (e) {
        emit(StatsErrorState(e.toString()));
      }
    });

    on<StatsDeleteTransactionEvent>((event, emit) async {
      try {
        emit(StatsLoadingState());
        await transactionRepo.deleteTransaction(event.transactionId);
        emit(StatsDeletedTransactionState("Transaction deleted successfully."));
      } catch (e) {
        emit(StatsErrorState(e.toString()));
      }
    });
  }
}
