import 'package:flutter/material.dart';

class SimpleRoute extends PageRoute {
  SimpleRoute({@required String name, @required this.title, @required this.builder, @required this.animated})
      : super(settings: RouteSettings(name: name));

  final String title;
  final WidgetBuilder builder;

  final bool animated;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 200);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return animated
        ? FadeTransition(
            opacity: animation,
            child: Title(
              title: this.title,
              color: Theme.of(context).primaryColor,
              child: builder(context),
            ),
          )
        : Title(
            title: this.title,
            color: Theme.of(context).primaryColor,
            child: builder(context),
          );
  }
}
