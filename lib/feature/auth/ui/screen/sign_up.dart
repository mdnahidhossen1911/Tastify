import 'package:flutter/material.dart';
import 'package:tastify/app/app_colors.dart';
import 'package:tastify/app/assets_path.dart';
import 'package:tastify/feature/auth/ui/screen/login_screen.dart';
import 'package:tastify/feature/auth/ui/widgets/screen_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static String name = 'signUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                  SizedBox(height: 62),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 40,
                      color: AppColor.themeColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  SizedBox(height: 3),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "username",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12),
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
                  SizedBox(height: 12),
                  Text(
                    "Password",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 3),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "*****************",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Confirm Password",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  SizedBox(height: 3),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "*****************",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 26),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          ///Need to put profile page Navigation
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.themeColor,
                          elevation: 0,
                        ),
                        child: Text(
                          "Sign Up",
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
                  SizedBox(height: 34),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade600)),
                        SizedBox(width: 10),
                        Text("Sign in with"),
                        SizedBox(width: 10),
                        Expanded(child: Divider(color: Colors.grey.shade600)),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        icon: Image.asset(AssetsPath.googleLogoPNG, width: 24),
                        onPressed: () {},

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Color(0xff565656), width: 0.6),
                          elevation: 0,
                        ),
                        label: Text(
                          "Continue with Goodle",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
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
