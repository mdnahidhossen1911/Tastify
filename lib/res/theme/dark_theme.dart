import 'package:flutter/material.dart';

ThemeData darkThemeData = ThemeData(
  colorSchemeSeed: Colors.deepOrange,
  scaffoldBackgroundColor: Color(0xff1c1918),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(color: Colors.white),
    backgroundColor: Color(0xff1c1918),
  ),
  iconTheme: IconThemeData(color: Colors.white),
  textTheme: TextTheme(
    titleMedium: TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.w800,
    ),
    titleSmall: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
    titleLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    labelSmall: TextStyle(
      fontSize: 10,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    labelLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
    backgroundColor: Color(0xff1c1918),
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
