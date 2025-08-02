import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastify/view_model/view_models.dart';

import '../../res/app_colors.dart';
import '../../res/component/circle_progress.dart';
import '../../res/component/screen_background.dart';
import '../../utils/utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({super.key, required this.email});

  static String name = 'change-password';
  String? email;

  @override
  State<ChangePasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  late ForgotPasswordViewModel _forgotPasswordViewModel;

  @override
  Widget build(BuildContext context) {
    _forgotPasswordViewModel = Provider.of<ForgotPasswordViewModel>(context);
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
                    SizedBox(height: 16),
                    CircleAvatar(
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios_new),
                      ),
                    ),
                    SizedBox(height: 90),
                    Text(
                      "Change password",
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
                      },
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

      final isSuccess = await _forgotPasswordViewModel.changePassword(
        email: widget.email!,
        pass: passwordController.text,
      );

      if (isSuccess) {
        Utils.showToast("Password set successfully");
        Navigator.pop(context);
      } else {
        Utils.showToast("Failed to set password. Please try again.");
        return;
      }
    }
  }
}
