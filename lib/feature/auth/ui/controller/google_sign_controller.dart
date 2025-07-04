import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tastify/core/app_logger.dart';


class GoogleSignController {
  final SupabaseClient supabase = Supabase.instance.client;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
    serverClientId: dotenv.env['GOOGLESIGNID'],
  );

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {

        final userData = await supabase
            .from('Users')
            .select('id, name, email, password, photo')
            .eq('email', googleUser.email)
            .limit(1)
            .maybeSingle();

        if (userData == null) {
          final response = await supabase.from('Users').insert({
            'name': googleUser.displayName,
            'email': googleUser.email,
          }).select().single();
          appLogger.i('new user added');
          appLogger.i(response);
        }

        else{
          appLogger.i(googleUser.email);
          appLogger.i(userData);
        }

        signOut();
      }
    } catch (error,stack) {
      print("Google Sign-In Error: $error");
      print("network error : $stack");
    }
  }




  Future<void> signOut() async {
    await _googleSignIn.signOut();
    print('User signed out successfully');
  }

}