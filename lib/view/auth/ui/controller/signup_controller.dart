import 'package:get/get.dart';

import '../../../../model/network_response.dart';
import '../../../../model/user_model.dart';
import '../../../../utils/app_logger.dart';
import '../../../../utils/secure_password.dart';
import '../../../../utils/supabase.dart';

class SignupController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<NetworkResponse> registerUser(UserModel user) async {
    _isLoading = true;
    update();

    try {
      final existing =
          await supabase
              .from('Users')
              .select('id')
              .eq('email', user.email)
              .limit(1)
              .maybeSingle();

      if (existing != null) {
        appLogger.w('Email already in use: ${user.email}');

        _isLoading = false;
        update();

        return NetworkResponse(
          isSuccess: false,
          errorMessage: "This email is already used!",
        );
      }

      final response =
          await supabase
              .from('Users')
              .insert({
                'name': user.name,
                'email': user.email,
                'password': securePassword(user.password),
                'photo': user.photo,
              })
              .select()
              .single();

      appLogger.i('User registered with ID: ${response['id']}');

      _isLoading = false;
      update();

      return NetworkResponse(
        isSuccess: true,
        responseData: {
          'id': response['id'],
          'name': response['name'],
          'email': response['email'],
          'photo': response['photo'],
        },
      );
    } catch (e, stack) {
      _isLoading = false;
      update();

      appLogger.e('Registration error', error: e, stackTrace: stack);
      return NetworkResponse(isSuccess: false, errorMessage: 'Error: $e');
    }
  }
}
