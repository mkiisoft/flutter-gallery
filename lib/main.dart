import 'package:flutter/material.dart';
import 'package:fluttergallery/utils/navigator.dart';
import 'package:fluttergallery/utils/utils.dart';

void main() => runApp(MainApp());


class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Utils.appName,
      onGenerateRoute: (settings) => NavigatorRoute.route(settings.name),
    );
  }
}
