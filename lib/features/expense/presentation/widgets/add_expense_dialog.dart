import 'package:ewallet/core/constants/view_constatnts.dart';
import 'package:ewallet/core/domain/entities/money.dart';
import 'package:ewallet/core/utils/helpers/id_generator.dart';
import 'package:ewallet/core/utils/helpers/ui_helpers.dart';
import 'package:ewallet/core/utils/widgets/custom_dropdown.dart';
import 'package:ewallet/core/utils/widgets/date_picker_textfield.dart';
import 'package:ewallet/core/utils/widgets/loader_widget.dart';
import 'package:ewallet/features/expense/domain/usecase/expense_params.dart';
import 'package:ewallet/features/expense/presentation/bloc/expense_bloc.dart';
import 'package:ewallet/features/shared/category/domain/entities/category.dart';
import 'package:ewallet/features/shared/category/presentation/bloc/category_bloc.dart';
import 'package:ewallet/features/shared/source/domain/entities/source.dart';
import 'package:ewallet/features/shared/source/presentation/bloc/source_bloc.dart';
import 'package:ewallet/features/transactions/domain/entities/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpenseDialog extends StatefulWidget {
  const AddExpenseDialog({super.key});

  @override
  State<AddExpenseDialog> createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  @override
  void initState() {
    context.read<SourceBloc>().add(FetchAllSources());
    context.read<CategoryBloc>().add(
      FetchCategories(categoryType: CategoryType.expense),
    );
    super.initState();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  Source? selectedSource;
  Category? selectedCategory;
  DateTime expenseDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Expense"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(hintText: "Title"),
            controller: titleController,
          ),
          SizedBox(height: ViewConstatnts.widgetsHeightGap),
          TextField(
            decoration: InputDecoration(hintText: "Description"),
            controller: descriptionController,
          ),
          SizedBox(height: ViewConstatnts.widgetsHeightGap),
          TextField(
            decoration: InputDecoration(hintText: "Amount"),
            controller: amountController,
          ),
          SizedBox(height: ViewConstatnts.widgetsHeightGap),
          BlocConsumer<SourceBloc, SourceState>(
            builder: (context, state) {
              if (state is SourceInProgress) {
                return LoaderWidget();
              } else if (state is AllSourcesSuccess) {
                return CustomDropdown(
                  items: state.sources,
                  itemTextMapper: (source) => source.name,
                  selectedItem: selectedSource,
                  onChanged: (source) {
                    if (source != selectedSource) {
                      setState(() {
                        selectedSource = source;
                      });
                    }
                  },
                  hintText: "Select Source",
                );
              }
              return SizedBox.shrink();
            },
            listener: (context, state) {
              if (state is SourceFailure) {
                showCustomSnackBar(context, state.message);
              }
            },
          ),
          SizedBox(height: ViewConstatnts.widgetsHeightGap),
          BlocConsumer<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryInProgress) {
                return LoaderWidget();
              } else if (state is CategoriesSuccess) {
                return CustomDropdown<Category>(
                  items: state.categories,
                  itemTextMapper: (category) => category.categoryName,
                  selectedItem: selectedCategory,
                  onChanged: (category) {
                    if (category != selectedCategory) {
                      setState(() {
                        selectedCategory = category;
                      });
                    }
                  },
                  hintText: "Select category",
                );
              }
              return SizedBox.shrink();
            },
            listener: (context, state) {
              if (state is CategoryFailure) {
                showCustomSnackBar(context, state.message);
              }
            },
          ),
          SizedBox(height: ViewConstatnts.widgetsHeightGap),
          DatePickerTextField(
            onDateChanged: (selectedDate) {
              expenseDate = selectedDate;
            },
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            SizedBox(width: ViewConstatnts.widgetsHeightGap / 2),
            BlocConsumer<ExpenseBloc, ExpenseState>(
              listener: (context, state) {
                if (state is AddExpenseSuccess) {
                  showCustomSnackBar(context, "Added Expense!");
                  Navigator.of(context).pop();
                } else if (state is AddExpenseError) {
                  showCustomSnackBar(context, state.addExpenseErrorMessage);
                }
              },
              builder: (context, state) {
                if (state is ExpenseLoading) {
                  return LoaderWidget();
                }
                return TextButton(
                  onPressed: () {
                    final double? amountInRupees = double.tryParse(
                      amountController.text,
                    );
                    final String title = titleController.text;
                    if (selectedCategory != null &&
                        selectedSource != null &&
                        title.isNotEmpty &&
                        amountInRupees != null) {
                      context.read<ExpenseBloc>().add(
                        AddExpense(
                          params: ExpenseParams(
                            expenseId: IdGenerator.id,
                            title: title,
                            description: descriptionController.text,
                            amount: Money.inRupees(amountInRupees),
                            transactionDate: expenseDate,
                            transactionCategory: selectedCategory!,
                            transactionType: TransactionType.expense,
                            fromSource: selectedSource!,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text("Add"),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
