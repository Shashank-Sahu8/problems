import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Themeclass {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
        background: CupertinoColors.white, //background1
        primary: Color(0xff7F3DFF),
        onPrimaryContainer: Color(0xfffebece), //containers background4
        onSurface: Color(0xffffefff), //background2
        secondary: Color(0xff8cd3d5), //containers background1
        onSecondaryContainer: Color(0xfff7a26b), //containers background2
        tertiary: Color(0xffc5aef6), //containers background3
        onTertiary: Color(0xffff597d), //botton
        surface: Color(0xff20a8a5), //active button
        onPrimary: Colors.black //text
        ),
  );

  static ThemeData dark = ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
          background: Color(0xff212121), //background1
          primary: Color(0xff7F3DFF),
          onPrimaryContainer: Color(0xfffebece), //containers background4
          onSurface: Color(0xff2c2c2c), //background poped
          secondary: Color(0xff8cd3d5), //containers background1
          onSecondaryContainer: Color(0xfff7a26b), //containers background2
          tertiary: Color(0xffc5aef6), //containers background3
          onTertiary: Color(0xffff597d), //botton
          surface: Color(0xff20a8a5), //active button
          onPrimary: Colors.white //text
          ));
}

//How to use-->
// color: colors.green x
// color: Theme.of(context).colorScheme.secondary
