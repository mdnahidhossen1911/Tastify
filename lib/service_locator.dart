import 'package:get_it/get_it.dart';
import 'package:tastify/res/theme/theme_changer.dart';
import 'package:tastify/view_model/forgot_password_view_model.dart';
import 'package:tastify/view_model/google_sign_view_model.dart';
import 'package:tastify/view_model/login_view_model.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<ThemeChanger>(ThemeChanger());

  //lazySingletons
  locator.registerLazySingleton<GoogleSignViewModel>(
    () => GoogleSignViewModel(),
  );
  locator.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  locator.registerLazySingleton<ForgotPasswordViewModel>(
    () => ForgotPasswordViewModel(),
  );
}
