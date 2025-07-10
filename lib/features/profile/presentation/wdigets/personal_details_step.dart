import 'package:ewallet/core/utils/widgets/date_picker_textfield.dart';
import 'package:flutter/material.dart';

class PersonalDetailsStep extends StatelessWidget {
  final TextEditingController nameController;
  final DateTime? pickedDate;
  final Function(DateTime) onDateChanged;

  const PersonalDetailsStep({
    super.key,
    required this.nameController,
    required this.pickedDate,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: "Full Name"),
        ),
        SizedBox(height: 12),
        DatePickerTextField(
          labelText: "Date of Birth",
          onDateChanged: onDateChanged,
        ),
      ],
    );
  }
}
