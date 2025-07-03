import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tastify/core/secure_password.dart';
import 'package:tastify/feature/auth/data/model/user_model.dart';
import 'package:tastify/core/network_response.dart';
import 'package:tastify/core/app_logger.dart';

class SignupController {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<NetworkResponse> registerUser(UserModel user) async {

    try {
      final existing = await supabase
          .from('Users')
          .select('id')
          .eq('email', user.email)
          .limit(1)
          .maybeSingle();

      if (existing != null) {
        appLogger.w('Email already in use: ${user.email}');
        return NetworkResponse(
          isSuccess: false,
          errorMessage: "This email is already used!",
        );
      }

      final response = await supabase.from('Users').insert({
        'name': user.name,
        'email': user.email,
        'password': securePassword(user.password),
        'photo': user.photo,
      }).select().single();

      appLogger.i('User registered with ID: ${response['id']}');

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
      appLogger.e('Registration error', error: e, stackTrace: stack);
      return NetworkResponse(
        isSuccess: false,
        errorMessage: 'Error: $e',
      );
    }
  }
}
