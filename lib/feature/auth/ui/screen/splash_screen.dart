import 'package:flutter/material.dart';
import 'package:tastify/feature/auth/ui/screen/login_screen.dart';
import 'package:tastify/feature/auth/ui/widgets/app_logo.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            AppLogo(),
            Spacer(),
            SizedBox(
                width: 100,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  color: Colors.orange,
                )),
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}


