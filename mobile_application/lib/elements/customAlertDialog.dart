import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final List<Widget>? actions; // Optional actions

  CustomAlertDialog({
    required this.title,
    required this.message,
    this.actions, // Initialize actions in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF294597),
              ),
            ),
            SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF294597),
              ),
            ),
            SizedBox(height: 20),
            if (actions != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Center buttons horizontally
                children: actions!,
              )
            else
              CustomElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: 'OK',
              ),
          ],
        ),
      ),
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
      return CustomAlertDialog(
        title: title,
        message: message,
        actions: [
          CustomElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              confirmed = false;
              if (onCancel != null) {
                onCancel();
              }
            },
            text: 'Nein',
          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              confirmed = true;
              onConfirm();
            },
            text: 'Ja',
          ),
        ],
      );
    },
  );
  return confirmed;
}
