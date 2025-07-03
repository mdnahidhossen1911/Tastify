import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tastify/core/network_response.dart';
import 'package:tastify/core/secure_password.dart';
import 'package:tastify/core/app_logger.dart';

class LoginController {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<NetworkResponse> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final userData =
          await supabase
              .from('Users')
              .select('id, name, email, password, photo')
              .eq('email', email)
              .limit(1)
              .maybeSingle();

      if (userData == null) {
        appLogger.w('User not found!');
        return NetworkResponse(
          isSuccess: false,
          errorMessage: "User not found!",
        );
      }

      if (userData['password'] != securePassword(password)) {
        appLogger.w('Incorrect password!');
        return NetworkResponse(
          isSuccess: false,
          errorMessage: 'Incorrect password!',
        );
      }

      appLogger.i(userData);
      return NetworkResponse(
        isSuccess: true,
        responseData: {
          'id': userData['id'],
          'name': userData['name'],
          'email': userData['email'],
          'photo': userData['photo'],
        },
      );

    } catch (e,stack) {
      appLogger.e('Registration error', error: e, stackTrace: stack);
      return NetworkResponse(
        isSuccess: false,
        errorMessage: 'Error: $e',
      );
    }
  }
}
