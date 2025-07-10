import 'package:ewallet/core/utils/helpers/icon_mapper.dart';
import 'package:ewallet/features/profile/data/constants/default_categories.dart';
import 'package:ewallet/features/shared/domain/entities/category.dart';
import 'package:flutter/material.dart';

class CategoriesStep extends StatelessWidget {
  final List<Category> selectedIncomeCategories;
  final List<Category> selectedExpenseCategories;
  final ValueChanged<List<Category>> onIncomeChanged;
  final ValueChanged<List<Category>> onExpenseChanged;

  const CategoriesStep({
    super.key,
    required this.selectedIncomeCategories,
    required this.selectedExpenseCategories,
    required this.onIncomeChanged,
    required this.onExpenseChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Expense Categories"),
        buildChips(
          expenseCategories,
          selectedExpenseCategories,
          onExpenseChanged,
        ),
        Divider(thickness: 5),
        Text("Income Categories"),
        buildChips(incomeCategories, selectedIncomeCategories, onIncomeChanged),
      ],
    );
  }

  Widget buildChips(
    List<Category> allCategories,
    List<Category> selectedCategories,
    ValueChanged<List<Category>> onChanged,
  ) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: allCategories.map((category) {
        final isSelected = selectedCategories.contains(category);
        return FilterChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(IconMapper.getIcon(category.iconKey)),
              SizedBox(width: 6),
              Text(category.categoryName),
            ],
          ),
          selected: isSelected,
          onSelected: (selected) {
            final newList = List<Category>.from(selectedCategories);
            if (selected) {
              newList.add(category);
            } else {
              newList.remove(category);
            }
            onChanged(newList);
          },
        );
      }).toList(),
    );
  }
}
