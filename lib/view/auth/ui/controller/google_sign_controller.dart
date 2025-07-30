import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tastify/utils/supabase_tables.dart';

import '../../../../model/network_response.dart';
import '../../../../utils/app_logger.dart';
import '../../../../utils/supabase.dart';

class GoogleSignController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: dotenv.env['GOOGLESIGNID'],
  );

  Future<NetworkResponse> signInWithGoogle() async {
    _isLoading = true;
    update();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final userInfo;
      if (googleUser != null) {
        final userData =
            await supaBase
                .from(SupaBaseTables.users)
                .select('id, name, email, password, photo')
                .eq('email', googleUser.email)
                .limit(1)
                .maybeSingle();

        if (userData == null) {
          final response =
              await supaBase
                  .from(SupaBaseTables.users)
                  .insert({
                    'name': googleUser.displayName,
                    'email': googleUser.email,
                  })
                  .select()
                  .single();
          appLogger.i('new user added');
          appLogger.i(response);
          userInfo = response;
        } else {
          appLogger.i(googleUser.email);
          appLogger.i(userData);
          userInfo = userData;
        }

        signOut();
        _isLoading = false;
        update();

        return NetworkResponse(
          isSuccess: true,
          responseData: {
            'id': userInfo['id'],
            'name': userInfo['name'],
            'email': userInfo['email'],
            'photo': userInfo['photo'],
          },
        );
      } else {
        _isLoading = false;
        update();
        return NetworkResponse(
          isSuccess: false,
          errorMessage: "Sign-in was cancelled by the user.",
        );
      }
    } catch (error, stack) {
      print("Google Sign-In Error: $error");
      print("network error : $stack");
      _isLoading = false;
      update();
      return NetworkResponse(errorMessage: error.toString(), isSuccess: false);
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    print('User signed out successfully');
  }
}
