import 'package:flutter/material.dart';
import 'package:fluttergallery/provider/dark_mode_provider.dart';
import 'package:fluttergallery/utils/navigator.dart';
import 'package:fluttergallery/utils/styles.dart';
import 'package:fluttergallery/utils/utils.dart';
import 'package:provider/provider.dart';

void main() => runApp(MainApp());

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme = await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => themeChangeProvider,
      child: Consumer<DarkThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            title: Utils.appName,
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            onGenerateRoute: (settings) => NavigatorRoute.route(settings.name),
          );
        },
      ),
    );
  }
}
