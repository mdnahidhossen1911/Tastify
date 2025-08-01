import 'package:flutter/material.dart';

class ThemeChanger extends ChangeNotifier {
  bool _values = false;
  bool get values => _values;
  ThemeMode _mode = ThemeMode.light;
  ThemeMode get mode => _mode;

  change(bool value) {
    _values = value;
    if (value) {
      _mode = ThemeMode.dark;
    } else {
      _mode = ThemeMode.light;
    }
    notifyListeners();
  }
}
