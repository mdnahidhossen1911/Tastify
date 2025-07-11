import 'package:tastify/core/app_logger.dart';
import 'package:tastify/core/network_response.dart';
import 'package:tastify/core/secure_password.dart';
import 'package:tastify/core/supabase.dart';

class ForgotPasswordController {

  Future<NetworkResponse> chackEmail({required String email}) async {
    try {
      final userData = await supabase
          .from('Users')
          .select('id')
          .eq('email', email)
          .limit(1)
          .maybeSingle();

      appLogger.i(userData);
      if(userData == null){
        return NetworkResponse(isSuccess: false,errorMessage: 'user not found');
      }else{
        return NetworkResponse(isSuccess: true);
      }


    } catch (error) {
      appLogger.e(error);
      return NetworkResponse(isSuccess: false,errorMessage: '$error');
    }
  }

  Future<bool> changePassword({required String email,required String pass}) async {
    try{

     await supabase.from('Users').update({'password': securePassword(pass)}).eq('email', email);
        appLogger.i('user password change successfully');
        return true;

    }catch(e){
      appLogger.e('error: $e');
      return false;
    }
  }

}