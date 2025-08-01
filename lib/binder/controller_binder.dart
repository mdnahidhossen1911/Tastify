import 'package:get/get.dart';

import '../view/auth/ui/controller/auth_controller.dart';
import '../view/category/controller/category_controller.dart';
import '../view/home/ui/controller/carousel_image_controller.dart';
import '../view/home/ui/controller/fetch_popular_item_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => GoogleSignController());
    // Get.lazyPut(() => LoginController());
    // Get.lazyPut(() => ForgotPasswordController());

    // Get.lazyPut(() => RecipeController());
    // Get.lazyPut(() => BlogController());
    // Get.lazyPut(() => MyRecipeController());

    // Get.put(GetRecipeController());
    Get.put(FetchPopularItemController());
    Get.put(CarouselImageController());
    Get.put(CategoryController());
    Get.put(AuthController());
  }
}
