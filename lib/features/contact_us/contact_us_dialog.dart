import 'package:edugate/core/app_colors.dart';
import 'package:flutter/material.dart';

class ContactUsDialog extends StatelessWidget {
  const ContactUsDialog({Key? key}) : super(key: key);

  static void show(BuildContext context) {
    showDialog(context: context, builder: (context) => const ContactUsDialog());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Contact Us"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Phone:", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text("+1 234 567 890"),
          SizedBox(height: 16),
          Text("Email:", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text("support@yourcompany.com"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "CLOSE",
            style: TextStyle(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
