import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Themeclass {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
        background: Colors.white, //background1
        primary: Color(0xffff597d),
        onPrimaryContainer: Color(0xfffebece), //containers background4
        onSurface: Colors.black, //, //text
        secondary: Color(0xff8cd3d5), //containers background1
        onSecondaryContainer: Color(0xfff7a26b), //containers background2
        tertiary: Color(0xfff2f2f2), //containers background3
        onTertiary: Color(0xffff597d), //button
        surface: Color(0xff20a8a5), //active button
        onPrimary: Colors.black //text change
        ),
  );

  static ThemeData dark = ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
          background: Color(0xff242424), //background1
          primary: Color(0xff7F3DFF),
          onPrimaryContainer: Color(0xfffebece), //containers background4
          onSurface: Colors.black, //Color(0xff1b1b1b), //default text
          secondary: Color(0xff8cd3d5), //containers background1
          onSecondaryContainer: Color(0xfff7a26b), //containers background2
          tertiary: Color(0xff1b1b1b), //containers background3
          onTertiary: Color(0xffff597d), //botton
          surface: Color(0xff20a8a5), //active button
          onPrimary: Colors.white //text change
          ));
}

//How to use-->
// color: colors.green x
// color: Theme.of(context).colorScheme.secondary
