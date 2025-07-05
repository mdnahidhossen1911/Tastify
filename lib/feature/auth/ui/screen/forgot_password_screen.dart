import 'package:flutter/material.dart';
import 'package:tastify/app/app_colors.dart';
import 'package:tastify/feature/auth/ui/screen/otp_verify_screen.dart';
import 'package:tastify/feature/auth/ui/screen/sign_up.dart';
import 'package:tastify/feature/auth/ui/widgets/screen_background.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static String name = 'forgotPasswordScreen';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
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
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "username@example.com",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 24),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, OtpVerifyScreen.name);
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
                          Navigator.pushNamed(context, SignUpScreen.name);
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
}
