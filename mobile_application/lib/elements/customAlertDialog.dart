import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;

  CustomAlertDialog({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}

Future<void> showAlert(BuildContext context, String title, String message) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(title: title, message: message);
    },
  );
}

Future<bool> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
  required VoidCallback onConfirm,
  VoidCallback? onCancel,
}) async {
  bool confirmed = false;
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onCancel != null) {
                onCancel();
              }
            },
            child: Text('Nein'),
          ),
          TextButton(
            onPressed: () {
              confirmed = true;
              onConfirm();
            },
            child: Text('Ja'),
          ),
        ],
      );
    },
  );
  return confirmed;
}