import 'package:flutter/material.dart';

class Theme {

  Color textColor;
  Color primaryColor;

  /// Home color
  Color homeCardColor;

  Theme ({
    required this.textColor,
    required this.primaryColor,
    required this.homeCardColor
  });

}


/// Dark theme
Theme darkTheme = Theme(

  textColor: Colors.white,
  primaryColor: Colors.black,

  /// Home
  homeCardColor: Colors.grey

);


/// Light theme
Theme lightTheme = Theme (

  textColor: Colors.black,
  primaryColor: Colors.white,

  /// Home
  homeCardColor: Colors.grey

);