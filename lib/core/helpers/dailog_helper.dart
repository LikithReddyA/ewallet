import 'package:flutter/material.dart';

class DailogHelper {
  DailogHelper._();

  static Future<void> showConfirmation({
    required BuildContext context,
    required String title,
    required String message,
  }) async {
    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(title: Text(title), content: Text(message));
      },
    );
  }
}
