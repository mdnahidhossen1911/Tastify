import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tastify/view/views.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/component/screen_background.dart';

class OtpVerifyScreen extends StatefulWidget {
  OtpVerifyScreen({super.key, required this.email});

  static String name = '/otpVerifyScreen';
  String? email;

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
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
                    "Verification Code",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Please enter the verification code that has been sent to username@example.com",
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: PinCodeTextField(
                      length: 4,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      backgroundColor: Colors.transparent,
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 68,
                        fieldWidth: 65,
                        activeColor: Color(0xffffe4d5),
                        activeFillColor: Color(0xffffe4d5),
                        inactiveColor: Color(0xffffe4d5),
                        selectedColor: AppColor.themeColor,
                        selectedFillColor: AppColor.themeColor,
                        inactiveFillColor: Colors.white,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      beforeTextPaste: (text) {
                        return true;
                      },
                      appContext: context,
                    ),
                  ),
                  SizedBox(height: 34),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          context.push(
                            SetPasswordScreen.name,
                            extra: widget.email,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.themeColor,
                          elevation: 0,
                        ),
                        child: Text(
                          "Verify",
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
                        "Haven't received a code?  ",
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          // resent
                        },
                        child: Text(
                          "Resend",
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
