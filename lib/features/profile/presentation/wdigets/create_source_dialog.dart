import 'package:ewallet/core/domain/entities/money.dart';
import 'package:ewallet/core/utils/helpers/id_generator.dart';
import 'package:ewallet/features/shared/source/domain/entities/source.dart';
import 'package:flutter/material.dart';

class CreateSourceDialog extends StatefulWidget {
  const CreateSourceDialog({super.key});

  @override
  State<CreateSourceDialog> createState() => _CreateSourceDialogState();
}

class _CreateSourceDialogState extends State<CreateSourceDialog> {
  final TextEditingController sourceNameController = TextEditingController();
  final TextEditingController sourceAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Create Source"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: sourceNameController,
              decoration: InputDecoration(hintText: "Name"),
            ),
            TextField(
              controller: sourceAmountController,
              decoration: InputDecoration(hintText: "Amount"),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            if (sourceNameController.text.isNotEmpty &&
                sourceAmountController.text.isNotEmpty) {
              Navigator.pop(
                context,
                Source(
                  sourceId: IdGenerator.id,
                  name: sourceNameController.text,
                  money: Money.inRupees(
                    double.parse(sourceAmountController.text),
                  ),
                ),
              );
            }
          },
          child: Text("Add"),
        ),
      ],
    );
  }
}
