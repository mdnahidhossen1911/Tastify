import 'package:flutter/material.dart';
import 'package:tastify/feature/auth/ui/screen/splash_screen.dart';

import 'app_routes.dart';

class TastifyApp extends StatelessWidget {
  const TastifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepOrange,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
              color: Color(0xffb0b0b0),
              fontSize: 15
          ),
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffffe4d5)),
              borderRadius: BorderRadius.circular(8)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffffe4d5)),
              borderRadius: BorderRadius.circular(8)
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffffe4d5)),
              borderRadius: BorderRadius.circular(8)
          ),
          filled: true,
          fillColor: Colors.white,
        )
      ),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: SplashScreen.name,
    );
  }
}
