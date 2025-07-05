import 'package:flutter/material.dart';
import 'package:tastify/app/app_colors.dart';
import 'package:tastify/app/assets_path.dart';
import 'package:tastify/feature/auth/ui/screen/forgot_password_screen.dart';
import 'package:tastify/feature/auth/ui/screen/sign_up.dart';
import 'package:tastify/feature/auth/ui/widgets/screen_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String name = 'loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  SizedBox(height: 96),
                  Text(
                    "Welcome to",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 40,height: 1),
                  ),
                  Text(
                    "Tastify",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 40,
                      color: AppColor.themeColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "A smart space to explore, share, and manage your favorite recipes.",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    decoration: InputDecoration(hintText: "username@example.com"),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Password",
                    style: TextStyle(fontWeight:FontWeight.w600, fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "*****************",
                      suffixIcon: Icon(Icons.remove_red_eye_outlined,color: Colors.grey,),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ForgotPasswordScreen.name);
                      },
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: AppColor.themeColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.themeColor,
                          elevation: 0,
                        ),
                        child: Text(
                          "Login",
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
                        "Don't have an account?  ",
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignUpScreen.name);
                        },
                        child: Text(
                          "Sign Up",
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
