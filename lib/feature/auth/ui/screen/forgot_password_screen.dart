import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastify/app/app_colors.dart';
import 'package:tastify/core/utils/circle_progress.dart';
import 'package:tastify/core/utils/utils.dart';
import 'package:tastify/feature/auth/ui/controller/forgot_password_controller.dart';
import 'package:tastify/feature/auth/ui/screen/otp_verify_screen.dart';
import 'package:tastify/feature/auth/ui/widgets/screen_background.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static String name = 'forgotPasswordScreen';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final ForgotPasswordController forgotPasswordController = Get.find<ForgotPasswordController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();


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
                  Form(
                    key: _formKey ,
                    child: TextFormField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction ,
                      decoration: InputDecoration(
                        hintText: "username@example.com",
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                  GetBuilder(
                    init: forgotPasswordController,
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
      final response = await forgotPasswordController.chackEmail(email: emailController.text);
     if( response.isSuccess) {
        Navigator.pushReplacementNamed(context, OtpVerifyScreen.name,arguments: emailController.text.trim());
     }else{
       Utils.showFlushBar(context, response.errorMessage);
     }

    }
  }

}
