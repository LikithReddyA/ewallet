import 'package:ewallet/core/extensions/datetime_extension.dart';
import 'package:flutter/material.dart';

class DatePickerTextField extends StatefulWidget {
  final String labelText;
  final ValueChanged<DateTime> onDateChanged;

  const DatePickerTextField({
    super.key,
    required this.onDateChanged,
    this.labelText = 'Select Date',
  });

  @override
  State<DatePickerTextField> createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  TextEditingController dateController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Format as yyyy-MM-dd
      // final formatted =
      //     "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      dateController.text = pickedDate.ddmmyyyyFormat();
      widget.onDateChanged(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: dateController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () => _selectDate(context),
    );
  }
}
