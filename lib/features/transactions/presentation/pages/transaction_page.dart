import 'package:ewallet/features/transactions/presentation/pages/all_expenses_page.dart';
import 'package:ewallet/features/transactions/presentation/pages/all_incomes_page.dart';
import 'package:ewallet/features/transactions/presentation/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTabBar(
      tabItems: [
        TabItem(title: "Income", icon: FontAwesomeIcons.moneyBillWave),
        TabItem(title: "Expense", icon: FontAwesomeIcons.moneyBillTransfer),
      ],
      tabContents: [AllIncomesPage(), AllExpensesPage()],
    );
  }
}
