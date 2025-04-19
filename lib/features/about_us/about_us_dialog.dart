import 'package:edugate/core/app_colors.dart';
import 'package:flutter/material.dart';

class AboutUsDialog extends StatelessWidget {
  const AboutUsDialog({Key? key}) : super(key: key);

  static void show(BuildContext context) {
    showDialog(context: context, builder: (context) => const AboutUsDialog());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("About Us"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Our Company", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(
              "We are dedicated to delivering the best digital solutions. "
              "Our mission is to provide high-quality, reliable, and efficient applications "
              "that solve real-world problems and bring value to our users.",
            ),
            SizedBox(height: 16),
            Text("Contact Us", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Email: contact@ourcompany.com"),
            Text("Phone: +1 234 567 890"),
          ],
        ),
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
