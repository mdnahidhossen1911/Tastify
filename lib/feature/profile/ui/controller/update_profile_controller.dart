import 'package:tastify/core/app_logger.dart';
import 'package:tastify/core/supabase.dart';

class UpdateProfileController {
   
  Future<bool> updateName(String name) async {
    try {
      final userData = await supabase
          .from('Users')
          .update({'name': name})
          .eq('id', '00eb5dfd-9d07-4754-bae3-47e1dd0cc8cd')
          .select('id ,name');

      appLogger.i('Change User name successfully. \n$userData');
      return true;
    } catch (e) {
      appLogger.e(e);
      return false;
    }
  }


  Future<bool> updatePhoto(String image) async {
    try {
      final userData = await supabase
          .from('Users')
          .update({'photo': image})
          .eq('id', '00eb5dfd-9d07-4754-bae3-47e1dd0cc8cd')
          .select('id ,name , photo');

      appLogger.i('Change User photo successfully. \n$userData');
      return true;
    } catch (e) {
      appLogger.e(e);
      return false;
    }
  }
}
