import 'package:equatable/equatable.dart';

sealed class AddTransactionState extends Equatable {
  const AddTransactionState();
  @override
  List<Object?> get props => [];
}

class AddTransactionInitial extends AddTransactionState {}

class AddTransactionLoading extends AddTransactionState {}

class AddTransactionSuccess extends AddTransactionState {
  final String successMessage;
  const AddTransactionSuccess(this.successMessage);
}

class AddTransactionError extends AddTransactionState {
  final String errorMessage;
  const AddTransactionError(this.errorMessage);
}
