import 'package:flutter/material.dart';
import 'package:tastify/app/assets_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static String name = 'splashscreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(255, 230, 230, 1),
                Color.fromRGBO(255, 255, 233, 1),
            // Color.fromARGB(255, 230, 230, 1),
            // Color.fromARGB(255, 255, 233, 1)
          ]),
        ),
        child: Center(
          child: Image.asset(AssetsPath.appLogoPNG, height: 60, width: 210),
        ),
      ),
    );
  }
}
