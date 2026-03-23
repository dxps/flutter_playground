import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/transaction_repo.dart';
import 'add_transaction_event.dart';
import 'add_transaction_state.dart';

class AddTransactionBloc extends Bloc<AddTransactionEvent, AddTransactionState> {
  TransactionRepo transactionRepo;

  AddTransactionBloc(this.transactionRepo) : super(AddTransactionInitial()) {
    on<SubmitTransactionEvent>(
      (event, emit) async {
        emit(AddTransactionLoading());
        try {
          await transactionRepo.addTransaction(event.transaction);
          emit(AddTransactionSuccess("Transaction added successfully."));
        } catch (e) {
          emit(AddTransactionError(e.toString()));
        }
      },
    );
  }
}
