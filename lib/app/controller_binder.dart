import 'package:get/get.dart';
import 'package:tastify/feature/auth/ui/controller/forgot_password_controller.dart';
import 'package:tastify/feature/auth/ui/controller/google_sign_controller.dart';
import 'package:tastify/feature/auth/ui/controller/login_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => GoogleSignController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => ForgotPasswordController());
  }
}