import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tastify/feature/auth/data/model/auth_user_model.dart';

class AuthController extends GetxController{
  static String? uid;
  static AuthUserModel? userModel;

  static const String _uidKey = 'uidKey';
  static const String _modelKey = 'modelKey';

  static Future<void> saveData(String id,AuthUserModel userModel) async {
    print(userModel.uid);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_uidKey, userModel.uid ?? '');
    await prefs.setString(_modelKey, jsonEncode(userModel));
    uid = id;
    userModel = userModel;
  }

  static Future<void> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataModel = prefs.getString(_modelKey);
    if (userDataModel != null) {
      userModel = AuthUserModel.fromJson(jsonDecode(userDataModel));
      uid = userModel?.uid;
    }
  }

  static Future<void> updateData(AuthUserModel userModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_uidKey, userModel.uid ?? '');
    await prefs.setString(_modelKey, jsonEncode(userModel));
    uid = userModel.uid;
    userModel = userModel;
  }

  static Future<bool> isLogIn()async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userid = sharedPreferences.getString(_uidKey);
    if(userid !=null){
      getData();
      return true;
    }else{
      return false;
    }
  }

  static Future<void> logOut() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}