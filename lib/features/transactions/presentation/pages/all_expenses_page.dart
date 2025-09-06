import 'package:ewallet/core/utils/widgets/loader_widget.dart';
import 'package:ewallet/features/expense/presentation/bloc/expense_bloc.dart';
import 'package:ewallet/features/transactions/presentation/widgets/transaction_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllExpensesPage extends StatefulWidget {
  const AllExpensesPage({super.key});

  @override
  State<AllExpensesPage> createState() => _AllExpensesPageState();
}

class _AllExpensesPageState extends State<AllExpensesPage> {
  @override
  void initState() {
    context.read<ExpenseBloc>().add(FetchAllExpenses());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: BlocConsumer<ExpenseBloc, ExpenseState>(
          listener: (context, state) {
            if (state is AddExpenseSuccess) {
              context.read<ExpenseBloc>().add(FetchAllExpenses());
            }
          },
          builder: (context, state) {
            if (state is AllExpensesSuccess) {
              var expenseTransactions = state.allExpenseTransactions;
              return Column(
                children: expenseTransactions
                    .map((income) => TransactionListTile(transaction: income))
                    .toList(),
              );
            } else if (state is ExpenseLoading) {
              return LoaderWidget();
            } else if (state is ExpenseError) {
              return Text(state.expenseErrorMessage);
            } else {
              return Text("Something went wrong");
            }
          },
        ),
      ),
    );
  }
}
