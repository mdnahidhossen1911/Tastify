import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastify/app/app_colors.dart';
import 'package:tastify/core/utils/circle_progress.dart';
import 'package:tastify/core/utils/utils.dart';
import 'package:tastify/feature/auth/ui/controller/forgot_password_controller.dart';
import 'package:tastify/feature/auth/ui/screen/login_screen.dart';
import 'package:tastify/feature/auth/ui/widgets/screen_background.dart';

class SetPasswordScreen extends StatefulWidget {
  SetPasswordScreen({super.key, required this.email});

  static String name = 'setPasswordScreen';
  String? email;

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final ForgotPasswordController _forgotPasswordController = Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 120),
                    Text(
                      "Set password",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 36,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Minimum length password 8 character with Latter and number combination.",
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 3),
                    TextFormField(
                      controller: passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: "*****************",
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 12),
                    Text(
                      "Confirm Password",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 3),
                    TextFormField(
                      controller: confirmPasswordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: "*****************",
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    GetBuilder(
                      init: _forgotPasswordController,
                      builder: (controller) {
                        return Visibility(
                          visible: !controller.isLoading,
                          replacement: circleProgress(),
                          child: Center(
                            child: SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                onPressed: () {
                                  setPassword();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.themeColor,
                                  elevation: 0,
                                ),
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    ),

                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?  ",
                          style: TextStyle(color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, LoginScreen.name);
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: AppColor.themeColor,
                              fontWeight: FontWeight.w800,
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
        ),
      ),
    );
  }

  setPassword() async {
    if (_formKey.currentState!.validate()) {
      print("Password set successfully for ${widget.email}");

      final isSuccess = await _forgotPasswordController.changePassword(
        email: widget.email!,
        pass: passwordController.text,
      );

      if(isSuccess){
        Utils.showToast("Password set successfully");
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.name,
              (route) => false,
        );
      } else {
        Utils.showToast("Failed to set password. Please try again.");
        return;
      }

    }
  }
}
