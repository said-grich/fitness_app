import 'package:fitness_app/core/test_style.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class Stlyes {

  static ThemeData stripeThemeData() {
    return ThemeData(
      cardColor:grayback ,
      textTheme: TextTheme(

        bodyText1: headline1.copyWith(fontSize: 18 ),
        bodyText2: headline1


      ),
      fontFamily: 'Cairo',
    );
  }
  static ThemeData themeData() {
    return ThemeData(
      fontFamily: 'Cairo',
      primarySwatch: Colors.blue,
      
    );
  }
}