import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/transaction_bloc/add_transaction_bloc.dart';
import '../../blocs/transaction_bloc/add_transaction_event.dart';
import '../../blocs/transaction_bloc/add_transaction_state.dart';
import '../../cubits/home/home_cubit.dart';
import '../../data/models/category_model.dart';
import '../../data/models/transaction_model.dart';
import '../../utils/category_list.dart';
import '../../utils/constants.dart';
import '../../utils/format_date.dart';
import '../../utils/show_snackbar.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  TransactionType _selectedType = TransactionType.expense;
  CategoryModel _selectedCategory = expenseCategoryList.first;
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _amountController = TextEditingController(text: "");

  @override
  void dispose() {
    _amountController.dispose(); // To avoid any memory leaks.
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(DateTime.now().year, 1, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  bool get _isAmountValid {
    final text = _amountController.text.trim();
    if (text.isEmpty) return false;

    return double.tryParse(text) != null;
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<CategoryModel>> categoryItems = _selectedType == TransactionType.expense
        ? expenseCategoryList.map((category) => _buildCategoryItem(category)).toList()
        : incomeCategoryList.map((category) => _buildCategoryItem(category)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Transaction"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  _buildCategoriesRadioButtons(),
                ],
              ),
              const SizedBox(height: defaultSpacing),

              DropdownButtonFormField<CategoryModel>(
                items: categoryItems,
                initialValue: _selectedCategory,
                onChanged: (value) => _selectedCategory = value!,
                decoration: const InputDecoration(labelText: "Category", border: OutlineInputBorder()),
              ),
              const SizedBox(height: defaultSpacing),

              TextField(
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: const InputDecoration(labelText: "Amount (\$)", border: OutlineInputBorder()),
                onChanged: (_) => setState(() {}), // To rebuild the widget while the user types.
              ),
              const SizedBox(height: defaultSpacing),

              TextButton(
                onPressed: () => _selectDate(context),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(defaultSpacing + 5.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(Radius.circular(defaultRadius / 2)),
                    side: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDate(_selectedDate),
                      style: const TextStyle(color: Colors.black, fontSize: defaultFontSize),
                    ),
                    const Icon(Icons.calendar_today_outlined, color: Colors.black),
                  ],
                ),
              ),
              const SizedBox(height: defaultSpacing),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesRadioButtons() {
    Widget transactionTypeOption(TransactionType type, String label) {
      return InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          setState(() {
            _selectedType = type;
            _selectedCategory = type == TransactionType.expense ? expenseCategoryList.first : incomeCategoryList.first;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<TransactionType>(
                value: type,
                activeColor: Theme.of(context).primaryColor,
              ),
              Text(label),
            ],
          ),
        ),
      );
    }

    return RadioGroup<TransactionType>(
      groupValue: _selectedType,
      onChanged: (TransactionType? value) {
        if (value == null) return;

        setState(() {
          _selectedType = value;
          _selectedCategory = value == TransactionType.expense ? expenseCategoryList.first : incomeCategoryList.first;
        });
      },
      child: Row(
        children: [
          transactionTypeOption(TransactionType.expense, 'Expense'),
          const SizedBox(width: 16),
          transactionTypeOption(TransactionType.income, 'Income'),
        ],
      ),
    );
  }

  DropdownMenuItem<CategoryModel> _buildCategoryItem(CategoryModel category) {
    return DropdownMenuItem(
      value: category,
      child: Row(
        children: [
          Icon(category.icon, color: category.color),
          const SizedBox(width: defaultSpacing),
          Text(category.name),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    Widget submitButton = BlocConsumer<AddTransactionBloc, AddTransactionState>(
      listener: (context, state) {
        if (state is AddTransactionSuccess) {
          context.read<HomeCubit>().loadTransactions();
          showSnackbar(context, state.successMessage);
          setState(() {
            _amountController.clear();
            _selectedDate = DateTime.now();
          });
        } else if (state is AddTransactionError) {
          showSnackbar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        if (state is AddTransactionLoading) {
          return const CircularProgressIndicator();
        }
        return ElevatedButton(
          onPressed: _isAmountValid
              ? () {
                  debugPrint(
                    "Category: ${_selectedCategory.name}, Amount: ${_amountController.text}, Date: ${formatDate(_selectedDate)}",
                  );
                  var txn = TransactionModel(
                    id: _selectedDate.millisecondsSinceEpoch % (1 << 28),
                    amount: double.parse(_amountController.text),
                    category: _selectedCategory,
                    type: _selectedType,
                    date: _selectedDate,
                  );
                  context.read<AddTransactionBloc>().add(SubmitTransactionEvent(txn));
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColorDark,
            disabledBackgroundColor: Colors.grey,
          ),
          child: const Text(
            'Submit',
            style: TextStyle(
              color: Colors.white,
              fontSize: defaultFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );

    return !_isAmountValid
        ? Tooltip(
            message: 'Enter a valid numeric amount.',
            child: submitButton,
          )
        : submitButton;
  }
}
