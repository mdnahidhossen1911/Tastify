import 'package:flutter/material.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40),
              ),
              Text(
                "Testify",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  color: Color.fromRGBO(253, 96, 17, 1),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "A smart space to explore, share, and manage your favorite recipes.",
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
              SizedBox(height: 12),
              Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 3),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "*****************",
                  suffixIcon: Icon(Icons.remove_red_eye_outlined),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, ForgotPasswordScreen.name);
                  },
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color.fromRGBO(253, 96, 17, 1),
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
                      backgroundColor: Color.fromRGBO(253, 96, 17, 1),
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
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.black),),
                    TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, SignUpScreen.name);
                      },
                      child: Text("Sign Up",
                          style: TextStyle(color: Color.fromRGBO(253, 96, 17, 1)),
                        ),
                    )
                ],
              ),
              SizedBox(height: 24),
              // Center(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       SizedBox(
              //           height: 4,
              //           width: double.infinity,
              //           child: Divider(color: Colors.red, thickness: 20,)),
              //       SizedBox(width: 8),
              //       Text("Sign in with"),
              //       SizedBox(width: 8),
              //       Divider(color: Colors.black, thickness: 20,),
              //     ],
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("_______________"),
                  Text("Sign in with"),
                  Text("_______________")
                ],
              ),
              SizedBox(height: 32),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.login_outlined),
                    onPressed: () {},

                    style: ElevatedButton.styleFrom(

                      backgroundColor: Colors.white,
                    ), label: Text(
                    "Continue with Goodle",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
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
    );
  }
}
