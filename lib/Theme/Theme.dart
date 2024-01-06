import 'package:flutter/material.dart';

import 'Theme_model.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = Themeclass.light;
  ThemeData get themeData => _themeData;
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == Themeclass.light)
      themeData = Themeclass.dark;
    else {
      themeData = Themeclass.light;
    }
  }
}
