import 'package:flutter/material.dart';
import 'package:tastify/view/auth/login_screen.dart';
import 'package:tastify/view/auth/splash_screen.dart';

import '../../model/recipe_model.dart';
import '../../view/auth/forgot_password_screen.dart';
import '../../view/auth/otp_verify_screen.dart';
import '../../view/auth/set_password_screen.dart';
import '../../view/auth/sign_up_screen.dart';
import '../../view/blog/add_blog_screen.dart';
import '../../view/blog/blog_details_screen.dart';
import '../../view/category/category_list_screen.dart';
import '../../view/category/category_wise_list_screen.dart';
import '../../view/common/main_bottom_nav_bar.dart';
import '../../view/feedback/ui/screens/recipe_feedback.dart';
import '../../view/home/featured_recipe_list_screen.dart';
import '../../view/home/popular_list_screen.dart';
import '../../view/home/search_list_screen.dart';
import '../../view/profile/ui/screens/change_password_screen.dart';
import '../../view/profile/ui/screens/my_recipe_screen.dart';
import '../../view/profile/ui/screens/profile_edit_screen.dart';
import '../../view/recipe/add_recipe_screen.dart';
import '../../view/recipe/recipe_details_screen.dart';
import '../../view/recipe/update_recipe_screen.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    debugPrint('Routes>>>>${settings.name}');
    late Widget route;
    if (settings.name == SplashScreen.name) {
      route = const SplashScreen();
    } else if (settings.name == LoginScreen.name) {
      route = const LoginScreen();
    } else if (settings.name == SignUpScreen.name) {
      route = const SignUpScreen();
    } else if (settings.name == ForgotPasswordScreen.name) {
      route = const ForgotPasswordScreen();
    } else if (settings.name == SetPasswordScreen.name) {
      String email = settings.arguments as String;
      route = SetPasswordScreen(email: email);
    } else if (settings.name == OtpVerifyScreen.name) {
      String email = settings.arguments as String;
      route = OtpVerifyScreen(email: email);
    } else if (settings.name == MainBottomNavBar.name) {
      route = const MainBottomNavBar();
    } else if (settings.name == CategoryListScreen.name) {
      route = const CategoryListScreen();
    } else if (settings.name == MyRecipeScreen.name) {
      route = const MyRecipeScreen();
    } else if (settings.name == FeaturedRecipeListScreen.name) {
      route = const FeaturedRecipeListScreen();
    } else if (settings.name == PopularListScreen.name) {
      route = const PopularListScreen();
    } else if (settings.name == SearchListScreen.name) {
      route = const SearchListScreen();
    } else if (settings.name == RecipeFeedbackScreen.name) {
      route = const RecipeFeedbackScreen();
    } else if (settings.name == ChangePasswordScreen.name) {
      String email = settings.arguments as String;
      route = ChangePasswordScreen(email: email);
    } else if (settings.name == RecipeDetailsScreen.name) {
      final Map<String, dynamic> args =
          settings.arguments as Map<String, dynamic>;
      route = RecipeDetailsScreen(recipeDetails: args);
    } else if (settings.name == AddRecipeScreen.name) {
      route = const AddRecipeScreen();
    } else if (settings.name == CategoryWiseListScreen.name) {
      final String categoryName = settings.arguments as String;
      route = CategoryWiseListScreen(categoryName: categoryName);
    } else if (settings.name == BlogDetailsScreen.name) {
      final Map<String, dynamic> data =
          settings.arguments as Map<String, dynamic>;
      route = BlogDetailsScreen(blogDetails: data);
    } else if (settings.name == AddBlogScreen.name) {
      route = const AddBlogScreen();
    } else if (settings.name == ProfileEditScreen.name) {
      route = const ProfileEditScreen();
    } else if (settings.name == UpdateRecipeScreen.name) {
      final RecipeModel recipeData = settings.arguments as RecipeModel;
      route = UpdateRecipeScreen(recipe: recipeData);
    }

    return MaterialPageRoute(
      builder: (context) {
        return route;
      },
    );
  }
}
