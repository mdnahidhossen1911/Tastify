import 'package:get/get.dart';
import 'package:tastify/service_locator.dart';

import '../../../../model/auth_user_model.dart';
import '../../../../utils/app_logger.dart';
import '../../../../utils/supabase.dart';
import '../../../../utils/supabase_tables.dart';
import '../../../../view_model/auth_view_model.dart';

class UpdateProfileController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> updateProfile(String name, String photoString) async {
    _isLoading = true;
    update();

    try {
      final userData = await supaBase
          .from(SupaBaseTables.users)
          .update({'name': name, 'photo': photoString})
          .eq('id', AuthViewModel.uid ?? '')
          .select('id ,name');

      AuthUserModel userModel = AuthUserModel(
        uid: AuthViewModel.uid,
        fullName: name,
        email: AuthViewModel().getGmail,
        photo: photoString,
      );
      locator<AuthViewModel>().updateData(userModel);

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
