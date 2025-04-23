import 'package:edugate/core/app_colors.dart';
import 'package:edugate/core/app_functions.dart';
import 'package:flutter/material.dart';

import '../apply_for_university/apply_for_university_screen.dart';
import '../home/models/university_model.dart';

class PayVisaScreen extends StatefulWidget {
  const PayVisaScreen({super.key, required this.item});
  final UniversityModel item;

  @override
  State<PayVisaScreen> createState() => _PayVisaScreenState();
}

class _PayVisaScreenState extends State<PayVisaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _pay() async {
    if (_formKey.currentState!.validate()) {
      // Trigger payment logic here
      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(SnackBar(content: Text('Processing Payment...')));
      context.showSuccessSnack('Processing Payment...');
      await Future.delayed(Duration(seconds: 3), () {
        context.showSuccessSnack('Payment Success');
      });
      await Future.delayed(Duration(seconds: 1), () {
        context.goToPage(ApplyForUniversityScreen(item: widget.item));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pay with Visa")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Name on Card",
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Enter name' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Card Number",
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.length != 16
                            ? 'Enter 16-digit card number'
                            : null,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _expiryDateController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: "MM/YY",
                        border: OutlineInputBorder(),
                      ),
                      validator:
                          (value) =>
                              value == null ||
                                      !RegExp(
                                        r"^(0[1-9]|1[0-2])\/\d{2}$",
                                      ).hasMatch(value)
                                  ? 'Invalid date'
                                  : null,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _cvvController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "CVV",
                        border: OutlineInputBorder(),
                      ),
                      validator:
                          (value) =>
                              value == null || value.length != 3
                                  ? 'Enter 3-digit CVV'
                                  : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _pay,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: Size.fromHeight(50),
                ),
                child: Text(
                  "Pay Now",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
