import 'package:blocify_expense_tracker/cubits/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'blocs/transaction_bloc/add_transaction_bloc.dart';
import 'config/routes/app_routes.dart';
import 'config/theme/app_theme.dart';
import 'data/models/transaction_model.dart';
import 'data/repos/transaction_repo.dart';
import 'utils/category_model_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());
  Hive.registerAdapter(TransactionModelAdapter());

  var transactionBox = await Hive.openBox<TransactionModel>("transactions");

  runApp(MyApp(transactionBox: transactionBox));
}

class MyApp extends StatelessWidget {
  final Box<TransactionModel> transactionBox;
  const MyApp({super.key, required this.transactionBox});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TransactionRepo(transactionBox),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AddTransactionBloc(context.read<TransactionRepo>())),
          BlocProvider(create: (context) => HomeCubit(context.read<TransactionRepo>())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'blocify | Expense Tracker',
          theme: appTheme,
          initialRoute: AppRoutes.dashboard,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
