import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/summary_model.dart';
import '../../data/repos/transaction_repo.dart';
import '../home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final TransactionRepo transactionRepo;

  HomeCubit(this.transactionRepo) : super(HomeLoadingState());

  SummaryModel calculateSummary() {
    var totalIncome = transactionRepo.getTotalIncome();
    var totalExpenses = transactionRepo.getTotalExpenses();
    var totalBalance = transactionRepo.getTotalBalance();
    return SummaryModel(
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      totalBalance: totalBalance,
    );
  }

  void loadTransactions() {
    try {
      emit(HomeLoadingState());
      var txns = transactionRepo.getLatestTransactions();
      var summary = calculateSummary();
      emit(HomeLoadedState(transactions: txns, summary: summary));
    } catch (e) {
      emit(HomeErrorState("Failed to load transactions."));
    }
  }

  Future<void> deleteTransaction(int id) async {
    await transactionRepo.deleteTransaction(id);
    emit(HomeDeletedTransactionState(message: "Transaction deleted."));
  }
}
