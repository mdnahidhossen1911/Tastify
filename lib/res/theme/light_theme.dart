import 'package:flutter/material.dart';

ThemeData lightThemeData = ThemeData(
  colorSchemeSeed: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(backgroundColor: Colors.white),
  textTheme: TextTheme(
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
    titleSmall: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
    titleLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
    labelMedium: TextStyle(fontWeight: FontWeight.bold),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0xffb0b0b0), fontSize: 15),
    border: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffffe4d5)),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffffe4d5)),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffffe4d5)),
      borderRadius: BorderRadius.circular(8),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffffe4d5)),
      borderRadius: BorderRadius.circular(8),
    ),
    filled: true,
    fillColor: Colors.white,
  ),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: Colors.deepOrange.withOpacity(0.05),
    labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>((
      Set<MaterialState> states,
    ) {
      if (states.contains(MaterialState.selected)) {
        return const TextStyle(color: Colors.deepOrange);
      }
      return const TextStyle(color: Colors.grey);
    }),
    iconTheme: MaterialStateProperty.resolveWith<IconThemeData>((
      Set<MaterialState> states,
    ) {
      if (states.contains(MaterialState.selected)) {
        return const IconThemeData(color: Colors.deepOrange);
      }
      return const IconThemeData(color: Colors.grey);
    }),
  ),
);
