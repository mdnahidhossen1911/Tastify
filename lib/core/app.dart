import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../binder/controller_binder.dart';
import '../res/theme/dark_theme.dart';
import '../res/theme/light_theme.dart';
import '../utils/routes/app_routes.dart';
import '../view/auth/ui/screen/splash_screen.dart';

class TastifyApp extends StatelessWidget {
  const TastifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: ThemeMode.system,
      initialBinding: ControllerBinder(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: SplashScreen.name,
    );
  }
}
