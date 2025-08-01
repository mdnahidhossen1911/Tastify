import 'package:flutter/cupertino.dart';
import 'package:tastify/utils/supabase_tables.dart';

import '../model/network_response.dart';
import '../utils/app_logger.dart';
import '../utils/secure_password.dart';
import '../utils/supabase.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<NetworkResponse> loginUser({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final userData =
          await supaBase
              .from(SupaBaseTables.users)
              .select('id, name, email, password, photo')
              .eq('email', email)
              .limit(1)
              .maybeSingle();

      if (userData == null) {
        appLogger.w('User not found!');

        _isLoading = false;
        notifyListeners();

        return NetworkResponse(
          isSuccess: false,
          errorMessage: "User not found!",
        );
      }

      if (userData['password'] != securePassword(password)) {
        appLogger.w('Incorrect password!');

        _isLoading = false;
        notifyListeners();

        return NetworkResponse(
          isSuccess: false,
          errorMessage: 'Incorrect password!',
        );
      }

      _isLoading = false;
      notifyListeners();

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
    } catch (e, stack) {
      _isLoading = false;
      notifyListeners();
      appLogger.e('Registration error', error: e, stackTrace: stack);
      return NetworkResponse(isSuccess: false, errorMessage: 'Error: $e');
    }
  }
}
