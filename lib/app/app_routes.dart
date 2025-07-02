import 'package:flutter/material.dart';
import 'package:tastify/feature/auth/ui/screen/login_screen.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    debugPrint('Routes>>>>${settings.name}');
    late Widget route;
    if (settings.name == LoginScreen.name) {
      route = const LoginScreen();
    }
    return MaterialPageRoute(
      builder: (context) {
        return route;
      },
    );
  }
}