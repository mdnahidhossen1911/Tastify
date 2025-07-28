import 'package:get/get.dart';

import '../../../../model/auth_user_model.dart';
import '../../../../utils/app_logger.dart';
import '../../../../utils/supabase.dart';
import '../../../auth/ui/controller/auth_controller.dart';

class UpdateProfileController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> updateProfile(String name, String photoString) async {
    _isLoading = true;
    update();

    try {
      final userData = await supabase
          .from('Users')
          .update({'name': name, 'photo': photoString})
          .eq('id', AuthController.uid ?? '')
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
