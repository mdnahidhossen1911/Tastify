import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastify/app/app_theme.dart';
import 'package:tastify/app/controller_binder.dart';
import 'package:tastify/feature/auth/ui/screen/splash_screen.dart';

import 'app_routes.dart';

class TastifyApp extends StatelessWidget {
  const TastifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      initialBinding: ControllerBinder(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: SplashScreen.name,
    );
  }
}
