import 'package:flutter/material.dart';
import 'package:fluttergallery/utils/utils.dart';

class HomeBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      height: 70,
      color: Utils.appBarColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100),
        child: Row(
          children: [
            FlutterLogo(style: FlutterLogoStyle.horizontal, size: 120, textColor: Colors.white),
            Text('Gallery', style: Utils.title),
            Expanded(child: SizedBox()),
            Visibility(visible: !isMobile, child: Text('About', style: Utils.h3)),
          ],
        ),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Utils.appBarColor,
      child: Row(
        children: [
          Expanded(child: Center(child: Text('© Mariano Zorrilla - 2020', style: Utils.h5))),
        ],
      ),
    );
  }
}