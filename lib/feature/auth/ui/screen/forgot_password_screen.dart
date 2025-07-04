import 'package:flutter/material.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Forgot password",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40),
              ),
              Text(
                "Please enter your email address to request a password reset.",
              ),
              SizedBox(height: 12),
              Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
                      backgroundColor: Color.fromRGBO(253, 96, 17, 1),
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
              SizedBox(height: 12),
              Row(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.black),),
                    TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, SignUpScreen.name);
                      },
                      child: Text("Login",
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
