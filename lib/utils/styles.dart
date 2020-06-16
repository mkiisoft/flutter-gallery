import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.purple,
      primaryColor: isDarkTheme ? Colors.black : Colors.grey,
      backgroundColor: isDarkTheme ? Color(0xFF303030) : Colors.white,
      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
      hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),
      highlightColor: isDarkTheme ? Color(0xffDDDDDD) : Color(0xff909090),
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xffCCCCCC),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cursorColor: isDarkTheme ? Colors.white : Colors.grey[700],
      textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(colorScheme: isDarkTheme
          ? ColorScheme.dark()
          : ColorScheme.light()),
      appBarTheme: AppBarTheme(elevation: 0),
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: isDarkTheme ? Colors.white : Colors.grey[700]
      )
    );
  }
}