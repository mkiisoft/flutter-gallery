import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergallery/pages/about.dart';
import 'package:fluttergallery/pages/home.dart';
import 'package:fluttergallery/provider/dark_mode_provider.dart';
import 'package:fluttergallery/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeBar extends StatelessWidget {
  const HomeBar({Key key, this.showAbout}) : super(key: key);

  final bool showAbout;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Container(
      height: 70,
      color: Utils.appBarColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(HomeScreen.route(true), (route) => false);
          },
          child: Row(
            children: [
              FlutterLogo(style: FlutterLogoStyle.horizontal, size: 120, textColor: Colors.white, colors: Utils.white),
              Text('Gallery', style: Utils.title.copyWith(color: Colors.white)),
              Expanded(child: SizedBox()),
              isMobile
                  ? Row(
                      children: [
                        Visibility(
                          visible: showAbout,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).push(AboutScreen.route(true));
                            },
                            child: Icon(Icons.info_outline, color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 20),
                        InkResponse(
                          onTap: () => themeChange.darkTheme = !themeChange.darkTheme,
                          child: FaIcon(
                            themeChange.darkTheme
                                ? FontAwesomeIcons.sun
                                : FontAwesomeIcons.moon,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Visibility(
                          visible: showAbout,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.of(context).push(AboutScreen.route(true));
                            },
                            child: Text('About', style: Utils.h3.copyWith(color: Colors.white)),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () => themeChange.darkTheme = !themeChange.darkTheme,
                          child: Text(themeChange.darkTheme ? 'Light Mode' : 'Dark Mode',
                              style: Utils.h3.copyWith(color: Colors.white)),
                        )
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Utils.appBarColor,
      child: Row(
        children: [
          Expanded(
              child: Center(child: Text('© Mariano Zorrilla - 2020', style: Utils.h5.copyWith(color: Colors.white)))),
        ],
      ),
    );
  }
}
