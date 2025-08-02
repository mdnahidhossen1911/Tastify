import 'package:get_it/get_it.dart';
import 'package:tastify/res/theme/theme_changer.dart';
import 'package:tastify/view_model/auth_view_model.dart';
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

final GetIt locator = GetIt.instance;

void setupLocator() {
  //singletons
  locator.registerSingleton<ThemeChanger>(ThemeChanger());
  locator.registerSingleton<GetRecipeViewModel>(GetRecipeViewModel());
  locator.registerSingleton<FetchPopularViewModel>(FetchPopularViewModel());
  locator.registerSingleton<CarouselImageViewModel>(CarouselImageViewModel());
  locator.registerSingleton<CategoryViewModel>(CategoryViewModel());
  locator.registerSingleton<AuthViewModel>(AuthViewModel());

  //lazySingletons
  locator.registerLazySingleton<GoogleSignViewModel>(
    () => GoogleSignViewModel(),
  );
  locator.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  locator.registerLazySingleton<ForgotPasswordViewModel>(
    () => ForgotPasswordViewModel(),
  );
  locator.registerLazySingleton<RecipeViewModel>(() => RecipeViewModel());
  locator.registerLazySingleton<BlogViewModel>(() => BlogViewModel());
  locator.registerLazySingleton<MyRecipeViewModel>(() => MyRecipeViewModel());
}
