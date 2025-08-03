import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tastify/view/views.dart';
import 'package:tastify/view_model/view_models.dart';

import '../../res/component/app_logo.dart';
import '../../res/component/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    moveToNextScreen();
  }

  Future<void> moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    bool isLogin = await AuthViewModel().isLogIn();
    if (isLogin) {
      if (mounted) context.go(MainBottomNavBar.name);
    } else {
      if (mounted) context.go(LoginScreen.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              AppLogo(),
              Spacer(),
              SizedBox(
                width: 120,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  minHeight: 6,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
