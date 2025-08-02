import 'package:flutter/material.dart';

import '../../res/component/app_logo.dart';
import '../../res/component/screen_background.dart';
import '../../view_model/auth_view_model.dart';
import '../common/main_bottom_nav_bar.dart';
import 'login_screen.dart';

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
      Navigator.pushReplacementNamed(context, MainBottomNavBar.name);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.name);
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
