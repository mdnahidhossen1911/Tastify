import 'package:get_it/get_it.dart';
import 'package:tastify/res/theme/theme_changer.dart';
import 'package:tastify/view_model/google_sign_view_model.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<ThemeChanger>(ThemeChanger());

  //lazySingletons
  locator.registerLazySingleton<GoogleSignViewModel>(
    () => GoogleSignViewModel(),
  );
}

// Register your services and controllers here
// Example:
// locator.registerLazySingleton<YourService>(() => YourService());
// locator.registerFactory<YourController>(() => YourController());

// For example, if you have a service called ApiService:
// locator.registerLazySingleton<ApiService>(() => ApiService());
