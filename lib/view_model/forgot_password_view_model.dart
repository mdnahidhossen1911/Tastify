import 'package:flutter/cupertino.dart';
import 'package:tastify/utils/supabase_tables.dart';

import '../model/network_response.dart';
import '../utils/app_logger.dart';
import '../utils/secure_password.dart';
import '../utils/supabase.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<NetworkResponse> chackEmail({required String email}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final userData =
          await supaBase
              .from(SupaBaseTables.users)
              .select('id')
              .eq('email', email)
              .limit(1)
              .maybeSingle();

      appLogger.i(userData);
      if (userData == null) {
        _isLoading = false;
        notifyListeners();

        return NetworkResponse(
          isSuccess: false,
          errorMessage: 'user not found',
        );
      } else {
        _isLoading = false;
        notifyListeners();

        return NetworkResponse(isSuccess: true);
      }
    } catch (error) {
      appLogger.e(error);

      _isLoading = false;
      notifyListeners();

      return NetworkResponse(isSuccess: false, errorMessage: '$error');
    }
  }

  Future<bool> changePassword({
    required String email,
    required String pass,
  }) async {
    _isLoading = true;

    try {
      await supaBase
          .from(SupaBaseTables.users)
          .update({'password': securePassword(pass)})
          .eq('email', email);
      appLogger.i('user password change successfully');

      _isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      appLogger.e('error: $e');

      _isLoading = false;
      notifyListeners();

      return false;
    }
  }
}
