import 'package:flutter/material.dart';

class ReusableDialog extends StatelessWidget {
  final String title;
  final String content;

  const ReusableDialog({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("حسناً"),
        ),
      ],
    );
  }
}