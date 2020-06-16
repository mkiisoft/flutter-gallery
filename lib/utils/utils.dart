import 'package:flutter/material.dart';

class Utils {
  static final String rootUrl = 'https://raw.githubusercontent.com/mkiisoft/flutter-gallery/master/';

  static final String appName = 'Flutter Gallery';
  static final String appPath = '/gallery';

  static final String aboutName = 'About';
  static final String aboutPath = '/about';

  static final Color appBarColor = Colors.deepPurple;

  static Color pwa(isDark) => isDark ? Colors.white : Color(0xFF5A0EC8);

  static final MaterialColor white = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(0xFFFFFFFF),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );

  static final TextStyle title = TextStyle(fontSize: 30);
  static final TextStyle h1 = TextStyle(fontSize: 22, fontWeight: FontWeight.w600);
  static final TextStyle h2 = TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
  static final TextStyle h3 = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  static final TextStyle h4 = TextStyle(fontSize: 16);
  static final TextStyle h5 = TextStyle(fontSize: 14);
  static final TextStyle h6 = TextStyle(fontSize: 12);
}