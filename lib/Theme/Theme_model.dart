import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Themeclass {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        background: CupertinoColors.white,
        primary: Colors.white38,
        onPrimaryContainer: Colors.black, //text color
        secondary: Colors.grey.shade100,
        onSecondaryContainer: Color(0xff8f8f8e), //second text
        tertiary: Color(0xff733E9E)),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: Color(0xff353535),
        primary: Color(0xff1a1a1a),
        onPrimaryContainer: Colors.white, //text color
        secondary: Color(0xff262626),
        onSecondaryContainer: Colors.white24,
        tertiary: Color(0xff633e9e)),
  );
}

//How to use-->
// color: colors.green x
// color: Theme.of(context).colorScheme.secondary
