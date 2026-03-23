import 'package:equatable/equatable.dart';

import '../../data/models/transaction_model.dart';

sealed class StatsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StatsLoadingState extends StatsState {}

class StatsLoadedState extends StatsState {
  final List<TransactionModel> transactions;
  final Set<DateTime> dates;

  StatsLoadedState({required this.transactions, required this.dates});

  @override
  List<Object?> get props => [transactions, dates];
}

class StatsErrorState extends StatsState {
  final String errorMessage;

  StatsErrorState(this.errorMessage);
}

class StatsDeletedTransactionState extends StatsState {
  final String message;

  StatsDeletedTransactionState(this.message);
}
