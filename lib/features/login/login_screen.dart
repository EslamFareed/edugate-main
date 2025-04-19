import 'package:edugate/core/app_colors.dart';
import 'package:edugate/core/app_functions.dart';
import 'package:edugate/features/login/cubit/login_cubit.dart';
import 'package:edugate/features/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: context.screenHeight * .05),
                SvgPicture.asset(
                  "assets/icons/icon.svg",
                  height: 100,
                  width: 100,
                ),
                Text(
                  "EduGate",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: context.screenHeight * .05),

                //! ------------------- Email ------------------!
                Row(children: [Text("Email")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.screenHeight * .05),

                //! ------------------- Password ------------------!
                Row(children: [Text("Password")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.screenHeight * .05),

                //! ------------------- Login Button ------------------!
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccessState) {
                      context.showSuccessSnack("Login successful");
                      context.goOffAll(HomeScreen());
                    } else if (state is LoginErrorState) {
                      context.showErrorSnack("Login failed");
                    }
                  },
                  builder: (context, state) {
                    return state is LoginLoadingState
                        ? Center(child: CircularProgressIndicator())
                        : MaterialButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              LoginCubit.get(context).login(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          minWidth: context.screenWidth,
                          height: 50,
                          color: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                  },
                ),
                SizedBox(height: 10),

                //! ------------------- Sign Up Link ------------------!
                Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    InkWell(
                      onTap: () {
                        context.goToPage(SignUpScreen());
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
