import 'package:get/get.dart';
import 'package:tastify/core/app_logger.dart';
import 'package:tastify/core/supabase.dart';
import 'package:tastify/feature/auth/data/model/auth_user_model.dart';
import 'package:tastify/feature/auth/ui/controller/auth_controller.dart';

class UpdateProfileController extends GetxController{

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> updateProfile(String name,String photoString) async {

    _isLoading = true;
    update();

    try {
      final userData = await supabase
          .from('Users')
          .update({'name': name, 'photo': photoString})
          .eq('id', AuthController.uid??'')
          .select('id ,name');

      AuthUserModel userModel = AuthUserModel(
          uid: AuthController.uid,
          fullName: name,
          email: AuthController().getGmail,
          photo: photoString,
      );
      Get.find<AuthController>().updateData(userModel);

      _isLoading = false;
      update();

      appLogger.i('Change User name successfully. \n$userData');
      return true;
    } catch (e) {
      appLogger.e(e);

      _isLoading = false;
      update();

      return false;
    }
  }

}
