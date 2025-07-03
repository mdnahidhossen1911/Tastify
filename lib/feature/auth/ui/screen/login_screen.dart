import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tastify/core/network_response.dart';
import 'package:tastify/feature/auth/data/model/user_model.dart';
import 'package:tastify/feature/auth/ui/controller/login_controller.dart';
import 'package:tastify/feature/auth/ui/controller/signup_controller.dart';

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
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(dotenv.env['APPNAME'] ?? ''),
            ElevatedButton(
              onPressed: () async {
                NetworkResponse result = await SignupController().registerUser(
                    UserModel(
                    name: 'Nahid Hossen',
                    email: 'nahid123@gmail.com',
                    password: 'password',
                    ),
                );

              },
              child: Text('signup'),
            ),

            ElevatedButton(
              onPressed: () async {
                NetworkResponse result = await LoginController().loginUser(
                    email: 'nahid1@gmail.com',
                    password: 'password');
              },
              child: Text('signin'),
            ),
          ],
        ),
      ),
    );
  }
}
