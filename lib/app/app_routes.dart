import 'package:flutter/material.dart';
import 'package:tastify/feature/auth/ui/screen/forgot_password_screen.dart';
import 'package:tastify/feature/auth/ui/screen/login_screen.dart';
import 'package:tastify/feature/auth/ui/screen/otp_verify_screen.dart';
import 'package:tastify/feature/auth/ui/screen/set_password_screen.dart';
import 'package:tastify/feature/auth/ui/screen/sign_up.dart';
import 'package:tastify/feature/auth/ui/screen/splash_screen.dart';
import 'package:tastify/feature/common/ui/screens/main_bottom_nav_bar.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    debugPrint('Routes>>>>${settings.name}');
    late Widget route;
    if (settings.name == SplashScreen.name) {
      route = const SplashScreen();
    }else if (settings.name == LoginScreen.name) {
      route = const LoginScreen();
    }else if (settings.name == SignUpScreen.name) {
      route = const SignUpScreen();
    }else if (settings.name == ForgotPasswordScreen.name) {
      route = const ForgotPasswordScreen();
    }else if (settings.name == SetPasswordScreen.name) {
      route = const SetPasswordScreen();
    }else if (settings.name == OtpVerifyScreen.name) {
      route = const OtpVerifyScreen();
    }
    else if(settings.name==MainBottomNavBar.name){
      route =const MainBottomNavBar();
    }
    return MaterialPageRoute(
      builder: (context) {
        return route;
      },
    );
  }
}