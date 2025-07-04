import 'package:flutter/material.dart';
import 'package:tastify/feature/auth/ui/controller/forgot_password_controller.dart';

class GoogleSignScreen extends StatefulWidget {
  const GoogleSignScreen({super.key});

  @override
  State<GoogleSignScreen> createState() => _GoogleSignScreenState();
}

class _GoogleSignScreenState extends State<GoogleSignScreen> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google sign'),),
      body: Center(child: ElevatedButton(onPressed: () {
        ForgotPasswordController().chackEmail(email: 'nahidhossen.mail@gmail.com');
        ForgotPasswordController()
            .changePassword(
            email: 'nahidhossen.mail@gmail.com',
            pass:  'pass'
        );
      }, child: Text('sign in')),),
    );
  }
}
