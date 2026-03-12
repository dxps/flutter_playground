import 'package:equatable/equatable.dart';

import '../data/models/summary_model.dart';
import '../data/models/transaction_model.dart';

sealed class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<TransactionModel> transactions;
  final SummaryModel summary;

  HomeLoadedState({required this.transactions, required this.summary});
}

class HomeErrorState extends HomeState {
  final String errorMessage;

  HomeErrorState(this.errorMessage);
}

class HomeDeletedTransactionState extends HomeState {
  final String message;

  HomeDeletedTransactionState({required this.message});
}
