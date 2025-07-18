import 'package:ewallet/app/router/routes.dart';
import 'package:ewallet/features/income/presentation/widgets/add_income_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatelessWidget {
  final Widget child;
  const NavBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex(context),
        onTap: (index) {
          _onTap(context, index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.moneyBillTransfer),
            label: "Transactions",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.chartPie),
            label: "Stats",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: "Profile",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.plus),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(title: Text("Expense"), onTap: () {}),
                    ListTile(
                      title: Text("Income"),
                      onTap: () {
                        Navigator.pop(context);
                        Future.delayed(Duration.zero, () {
                          if (!context.mounted) return;
                          showDialog(
                            context: context,
                            builder: (context) => AddIncomeDialog(),
                          );
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  int _currentIndex(BuildContext context) {
    final location = GoRouter.of(context).state.matchedLocation;
    if (location.startsWith(Routes.home.path)) {
      return 0;
    } else if (location.startsWith(Routes.transactionsPage.path)) {
      return 1;
    } else if (location.startsWith(Routes.statisticsPage.path)) {
      return 2;
    }
    return 3;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.goNamed(Routes.home.name);
        break;
      case 1:
        context.goNamed(Routes.transactionsPage.name);
        break;
      case 2:
        context.goNamed(Routes.statisticsPage.name);
        break;
      default:
        context.goNamed(Routes.profilePage.name);
        break;
    }
  }
}
