import 'package:get/get.dart';
import 'package:tastify/feature/auth/ui/controller/auth_controller.dart';
import 'package:tastify/feature/auth/ui/controller/forgot_password_controller.dart';
import 'package:tastify/feature/auth/ui/controller/google_sign_controller.dart';
import 'package:tastify/feature/auth/ui/controller/login_controller.dart';
import 'package:tastify/feature/blog/ui/controller/blog_controller.dart';
import 'package:tastify/feature/category/controller/category_controller.dart';
import 'package:tastify/feature/profile/ui/controller/my_recipe_controller.dart';
import 'package:tastify/feature/recipe/ui/controller/fetch_popular_item_controller.dart';
import 'package:tastify/feature/recipe/ui/controller/get_recipe_controller.dart';
import 'package:tastify/feature/recipe/ui/controller/recipe_controller.dart';
import '../feature/home/ui/controller/carousel_image_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => GoogleSignController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => ForgotPasswordController());

    Get.lazyPut(() => RecipeController());
    Get.lazyPut(() => BlogController());
    Get.lazyPut(() => MyRecipeController());

    Get.put(GetRecipeController());
    Get.put(FetchPopularItemController());
    Get.put(CarouselImageController());
    Get.put(CategoryController());
    Get.put(AuthController());
  }
}