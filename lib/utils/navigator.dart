import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttergallery/pages/details.dart';
import 'package:fluttergallery/pages/home.dart';
import 'package:fluttergallery/utils/simple_route.dart';
import 'package:fluttergallery/utils/utils.dart';
import 'package:universal_html/html.dart';

class NavigatorRoute extends StatefulWidget {
  final String path;

  static Route<dynamic> route(String path) {
    return SimpleRoute(name: '', title: Utils.appName, builder: (_) => NavigatorRoute(path: path), animated: false);
  }

  const NavigatorRoute({Key key, this.path}) : super(key: key);

  @override
  _NavigatorRouteState createState() => _NavigatorRouteState();
}

class _NavigatorRouteState extends State<NavigatorRoute> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (widget.path == '/gallery') {
        Navigator.of(context).pushAndRemoveUntil(HomeScreen.route(false), (_) => false);
        return;
      } else if (widget.path.contains('/app/')) {
        Navigator.of(context).pushAndRemoveUntil(SampleDetails.route(false, widget.path.split('/')[3]), (_) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(HomeScreen.route(false), (_) => false);
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
