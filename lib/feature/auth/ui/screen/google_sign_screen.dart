import 'package:flutter/material.dart';
import 'package:tastify/feature/auth/ui/controller/google_sign_controller.dart';
import 'package:tastify/feature/profile/ui/controller/update_profile_controller.dart';

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
       UpdateProfileController().updatePhoto('nahid.jpg');

      }, child: Text('sign in')),),
    );
  }
}
