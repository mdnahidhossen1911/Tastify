import 'package:flutter/material.dart';
import 'package:tastify/feature/auth/ui/screen/google_sign_screen.dart';
import 'app_routes.dart';

class TastifyApp extends StatelessWidget {
  const TastifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      home: GoogleSignScreen(),
    );
  }
}
