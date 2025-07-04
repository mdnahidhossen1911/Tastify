import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tastify/feature/auth/ui/screen/set_password_screen.dart';
import 'package:tastify/feature/auth/ui/screen/sign_up.dart';
import 'package:tastify/feature/auth/ui/widgets/screen_background.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  static String name = 'otpVerifyScreen';

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Verification Code",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
              ),
              Text(
                "Please enter the verification code that has been sent to username@example.com",
              ),
              SizedBox(height: 36),
              PinCodeTextField(
                length: 4,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                ),
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.white,
                enableActiveFill: true,

                //errorAnimationController: errorController,
                //controller: textEditingController,

                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                }, appContext: context,
              ),
              SizedBox(height: 36),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SetPasswordScreen.name);
                    },
                    child: Text(
                      "Verify",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(253, 96, 17, 1),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Row(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Haven't received a code?",
                    style: TextStyle(color: Colors.black),),
                    TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, SignUpScreen.name);
                      },
                      child: Text("Resend",
                          style: TextStyle(color: Color.fromRGBO(253, 96, 17, 1)),
                        ),
                    )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
