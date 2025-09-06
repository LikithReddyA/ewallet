import 'package:ewallet/core/constants/view_constatnts.dart';
import 'package:ewallet/core/extensions/money_extension.dart';
import 'package:ewallet/features/transactions/domain/entities/transaction.dart';
import 'package:flutter/material.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({super.key, required this.transaction});
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).listTileTheme.tileColor,
            border: Border.all(
              color: transaction.transactionType == TransactionType.income
                  ? Colors.green
                  : Colors.red,
            ),
          ),
          child: ListTile(
            title: Text(transaction.title),
            subtitle: Text(transaction.description ?? ""),
            trailing: Text(transaction.amount.format()),
          ),
        ),
        SizedBox(height: ViewConstatnts.widgetsHeightGap),
      ],
    );
  }
}
