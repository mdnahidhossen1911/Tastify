import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tastify/res/theme/theme_changer.dart';
import 'package:tastify/service_locator.dart';
import 'package:tastify/view_model/blog_view_model.dart';
import 'package:tastify/view_model/carousel_image_view_model.dart';
import 'package:tastify/view_model/category_view_model.dart';
import 'package:tastify/view_model/fetch_popular_view_model.dart';
import 'package:tastify/view_model/forgot_password_view_model.dart';
import 'package:tastify/view_model/get_recipe_view_model.dart';
import 'package:tastify/view_model/google_sign_view_model.dart';
import 'package:tastify/view_model/login_view_model.dart';
import 'package:tastify/view_model/my_recipe_view_model.dart';
import 'package:tastify/view_model/recipe_view_model.dart';

import '../binder/controller_binder.dart';
import '../res/theme/dark_theme.dart';
import '../res/theme/light_theme.dart';
import '../utils/routes/app_routes.dart';
import '../view/auth/ui/screen/splash_screen.dart';

class TastifyApp extends StatelessWidget {
  const TastifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<ThemeChanger>()),
        ChangeNotifierProvider(create: (_) => locator<GoogleSignViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<LoginViewModel>()),
        ChangeNotifierProvider(
          create: (_) => locator<ForgotPasswordViewModel>(),
        ),
        ChangeNotifierProvider(create: (_) => locator<RecipeViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<BlogViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<MyRecipeViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<GetRecipeViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<FetchPopularViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<CategoryViewModel>()),
        ChangeNotifierProvider(
          create: (_) => locator<CarouselImageViewModel>(),
        ),
        // Add other providers here if needed
      ],
      child: Builder(
        builder: (context) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightThemeData,
            darkTheme: darkThemeData,
            themeMode: Provider.of<ThemeChanger>(context).mode,
            initialBinding: ControllerBinder(),
            onGenerateRoute: AppRoutes.onGenerateRoute,
            initialRoute: SplashScreen.name,
          );
        },
      ),
    );
  }
}
