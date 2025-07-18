import 'package:flutter/material.dart';
import 'package:tastify/app/app_colors.dart';

circleProgress({Color? color}) =>
    Center(child: CircularProgressIndicator(color: color ?? AppColor.themeColor));
