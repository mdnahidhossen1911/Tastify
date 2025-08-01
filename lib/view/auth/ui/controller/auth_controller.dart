import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../model/auth_user_model.dart';
import '../../../../utils/app_logger.dart';

class AuthController extends GetxController {
  static String? uid;
  static AuthUserModel? userModel;

  String get getUid => uid ?? '';
  String get getUserName => userModel?.fullName ?? '';
  String get getGmail => userModel?.email ?? '';
  String get getPhoto => userModel?.photo ?? '';

  static const String _uidKey = 'uidKey';
  static const String _modelKey = 'modelKey';

  Future<void> saveData(String id, AuthUserModel userModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_uidKey, userModel.uid ?? '');
    await prefs.setString(_modelKey, jsonEncode(userModel));
    uid = id;
    userModel = userModel;
    appLogger.i("User data saved successfully with UID: ${userModel.email}");
    getData();
  }

  Future<void> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataModel = prefs.getString(_modelKey);
    if (userDataModel != null) {
      userModel = AuthUserModel.fromJson(jsonDecode(userDataModel));
      uid = userModel?.uid;
    }
  }

  Future<void> updateData(AuthUserModel userModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_modelKey, jsonEncode(userModel));
    userModel = userModel;
    await getData();
    update();
  }

  Future<bool> isLogIn() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? userid = sharedPreferences.getString(_uidKey);
    if (userid != null) {
      getData();
      return true;
    } else {
      return false;
    }
  }

  Future<void> logOut() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.clear();

    userModel = null;
    uid = null;

    update();
    appLogger.i("User logged out successfully");
  }
}
