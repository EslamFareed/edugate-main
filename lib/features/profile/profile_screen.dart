import 'package:edugate/core/app_colors.dart';
import 'package:edugate/core/app_functions.dart';
import 'package:edugate/features/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userData = LoginCubit.get(context).userData;
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: context.screenWidth,
              height: 250,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 45,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    LoginCubit.get(context).userData["name"],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildItem("Email", userData["email"], Icons.email),
                  _buildItem("Phone", userData["phone"], Icons.phone),
                  _buildItem(
                    "Gender",
                    userData["gender"],
                    userData["gender"] == "Male" ? Icons.male : Icons.female,
                  ),
                  _buildItem(
                    "Nationality",
                    userData["nationality"],
                    Icons.phone,
                  ),
                  _buildItem(
                    "Date of birth",
                    userData["dateOfBirth"],
                    Icons.phone,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String title, String label, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 10,
          children: [
            Icon(icon, color: AppColors.primary),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 10),
        Text(label),
        SizedBox(height: 10),
        Divider(),
        SizedBox(height: 10),
      ],
    );
  }
}
