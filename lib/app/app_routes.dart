import 'package:flutter/material.dart';
import 'package:tastify/feature/auth/ui/screen/forgot_password_screen.dart';
import 'package:tastify/feature/auth/ui/screen/login_screen.dart';
import 'package:tastify/feature/auth/ui/screen/otp_verify_screen.dart';
import 'package:tastify/feature/auth/ui/screen/set_password_screen.dart';
import 'package:tastify/feature/auth/ui/screen/sign_up_screen.dart';
import 'package:tastify/feature/auth/ui/screen/splash_screen.dart';
import 'package:tastify/feature/blog/ui/screens/add_blog_screen.dart';
import 'package:tastify/feature/blog/ui/screens/blog_details_screen.dart';
import 'package:tastify/feature/category/ui/screen/category_wise_list_screen.dart';
import 'package:tastify/feature/common/ui/screens/main_bottom_nav_bar.dart';
import 'package:tastify/feature/feedback/ui/screens/recipe_feedback.dart';
import 'package:tastify/feature/profile/ui/screens/change_password_screen.dart';
import 'package:tastify/feature/profile/ui/screens/my_recipe_screen.dart';
import 'package:tastify/feature/recipe/ui/screens/add_recipe_screen.dart';
import 'package:tastify/feature/recipe/ui/screens/category_list_screen.dart';
import 'package:tastify/feature/recipe/ui/screens/featured_recipe_list_screen.dart';
import 'package:tastify/feature/recipe/ui/screens/popular_list_screen.dart';
import 'package:tastify/feature/recipe/ui/screens/recipe_details_screen.dart';
import 'package:tastify/feature/recipe/ui/screens/search_list_screen.dart';

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
      String email = settings.arguments as String;
      route =  SetPasswordScreen(email: email);
    }else if (settings.name == OtpVerifyScreen.name) {
      String email = settings.arguments as String;
      route =  OtpVerifyScreen(email: email);
    }
    else if(settings.name==MainBottomNavBar.name){
      route =const MainBottomNavBar();
    }
    else if(settings.name==CategoryListScreen.name){
      route= const CategoryListScreen();
    }
    else if(settings.name==MyRecipeScreen.name){
      route= const MyRecipeScreen();
    }
    else if(settings.name==FeaturedRecipeListScreen.name){
      route= const FeaturedRecipeListScreen();
    }
    else if(settings.name==PopularListScreen.name){
      route= const PopularListScreen();
    }
    else if(settings.name==SearchListScreen.name){
      route= const SearchListScreen();
    }
    else if(settings.name==RecipeFeedbackScreen.name){
      route= const RecipeFeedbackScreen();
    }else if (settings.name == ChangePasswordScreen.name) {
      String email = settings.arguments as String;
      route =  ChangePasswordScreen(email: email);
    } else if(settings.name==RecipeDetailsScreen.name){
      final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      route=  RecipeDetailsScreen(recipeDetails: args,);
    }
    else if(settings.name==AddRecipeScreen.name){
      route= const AddRecipeScreen();
    }else if (settings.name == CategoryWiseListScreen.name) {
      final String categoryName = settings.arguments as String;
      route =  CategoryWiseListScreen(categoryName: categoryName,);
    }else if (settings.name == BlogDetailsScreen.name) {
      final Map<String,dynamic> data = settings.arguments as Map<String, dynamic>;
      route =  BlogDetailsScreen(blogDetails: data,);
    }else if(settings.name==AddBlogScreen.name){
      route= const AddBlogScreen();
    }


    return MaterialPageRoute(
      builder: (context) {
        return route;
      },
    );
  }
}