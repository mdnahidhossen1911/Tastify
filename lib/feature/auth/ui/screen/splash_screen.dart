import 'package:flutter/material.dart';
import 'package:tastify/feature/auth/ui/screen/login_screen.dart';
import 'package:tastify/feature/common/ui/widget/app_logo.dart';
import 'package:tastify/feature/auth/ui/widgets/screen_background.dart';

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

  Future<void> moveToNextScreen() async{
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, LoginScreen.name);
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
              SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}


