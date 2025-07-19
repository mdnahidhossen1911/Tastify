import 'package:get/get.dart';
import 'package:tastify/core/app_logger.dart';
import 'package:tastify/core/network_response.dart';
import 'package:tastify/core/secure_password.dart';
import 'package:tastify/core/supabase.dart';

class ForgotPasswordController extends GetxController  {

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<NetworkResponse> chackEmail({required String email}) async {

    _isLoading = true;
    update();

    try {
      final userData = await supabase
          .from('Users')
          .select('id')
          .eq('email', email)
          .limit(1)
          .maybeSingle();

      appLogger.i(userData);
      if(userData == null){

        _isLoading = false;
        update();

        return NetworkResponse(isSuccess: false,errorMessage: 'user not found');
      }else{

        _isLoading = false;
        update();

        return NetworkResponse(isSuccess: true);
      }


    } catch (error) {
      appLogger.e(error);

      _isLoading = false;
      update();

      return NetworkResponse(isSuccess: false,errorMessage: '$error');
    }
  }

  Future<bool> changePassword({required String email,required String pass}) async {

    _isLoading = true;

    try{

     await supabase.from('Users').update({'password': securePassword(pass)}).eq('email', email);
        appLogger.i('user password change successfully');

     _isLoading = false;
     update();

        return true;

    }catch(e){
      appLogger.e('error: $e');

      _isLoading = false;
      update();

      return false;
    }
  }

}