import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {


  static showToast(String message) {
    Fluttertoast.showToast(msg: message, gravity: ToastGravity.CENTER);
  }

  static showSnackBar(BuildContext context,String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }


  static showFlushBar(BuildContext context,String message){
    Flushbar(
      message: message,
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.symmetric(horizontal: 20),
      borderRadius: BorderRadius.circular(50),
      backgroundColor: Colors.red,
      icon: Icon(Icons.error,color: Colors.white,),
      duration: Duration(seconds: 2),
    ).show(context);

  }
}
