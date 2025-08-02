import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/app_colors.dart';
import '../../res/component/circle_progress.dart';
import '../../res/component/screen_background.dart';
import '../../utils/utils.dart';
import '../../view_model/forgot_password_view_model.dart';
import 'otp_verify_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static String name = 'forgotPasswordScreen';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late ForgotPasswordViewModel _forgotPasswordViewModel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _forgotPasswordViewModel = Provider.of<ForgotPasswordViewModel>(context);
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 120),
                  Text(
                    "Forgot password",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Please enter your email address to request a password reset.",
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  SizedBox(height: 3),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: "username@example.com",
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(
                          r'^[^@]+@[^@]+\.[^@]+',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                  Consumer<ForgotPasswordViewModel>(
                    builder: (context, value, child) {
                      return Visibility(
                        visible: !value.isLoading,
                        replacement: circleProgress(),
                        child: Center(
                          child: SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () {
                                chackEmail();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.themeColor,
                                elevation: 0,
                              ),
                              child: Text(
                                "Next",
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
                    },
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
                          Navigator.pop(context);
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
    );
  }

  chackEmail() async {
    if (_formKey.currentState!.validate()) {
      final response = await _forgotPasswordViewModel.chackEmail(
        email: emailController.text,
      );
      if (response.isSuccess) {
        Navigator.pushReplacementNamed(
          context,
          OtpVerifyScreen.name,
          arguments: emailController.text.trim(),
        );
      } else {
        Utils.showFlushBar(context, response.errorMessage);
      }
    }
  }
}
