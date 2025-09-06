import 'package:ewallet/core/utils/widgets/loader_widget.dart';
import 'package:ewallet/features/income/presentation/bloc/income_bloc.dart';
import 'package:ewallet/features/transactions/presentation/widgets/transaction_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllIncomesPage extends StatefulWidget {
  const AllIncomesPage({super.key});

  @override
  State<AllIncomesPage> createState() => _AllIncomesPageState();
}

class _AllIncomesPageState extends State<AllIncomesPage> {
  @override
  void initState() {
    context.read<IncomeBloc>().add(FetchAllIncomes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: BlocConsumer<IncomeBloc, IncomeState>(
          listener: (context, state) {
            if (state is AddIncomeSuccess) {
              context.read<IncomeBloc>().add(FetchAllIncomes());
            }
          },
          builder: (context, state) {
            if (state is AllIncomeSuccess) {
              var incomeTransactions = state.allIncomeTransactions;
              return Column(
                children: incomeTransactions
                    .map((income) => TransactionListTile(transaction: income))
                    .toList(),
              );
            } else if (state is IncomeLoading) {
              return LoaderWidget();
            } else if (state is IncomeError) {
              return Text(state.message);
            } else {
              return Text("Something went wrong");
            }
          },
        ),
      ),
    );
  }
}
