import 'package:flutter/material.dart';
import 'package:tastify/feature/auth/ui/screen/google_sign_screen.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    debugPrint('Routes>>>>${settings.name}');
    late Widget route;
    if (settings.name == GoogleSignScreen.name) {
      route = const GoogleSignScreen();
    }
    return MaterialPageRoute(
      builder: (context) {
        return route;
      },
    );
  }
}