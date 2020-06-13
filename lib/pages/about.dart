import 'package:flutter/material.dart';
import 'package:fluttergallery/utils/simple_route.dart';
import 'package:fluttergallery/utils/utils.dart';
import 'package:fluttergallery/utils/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  static Route<dynamic> route(bool animated) {
    return SimpleRoute(
        name: Utils.aboutPath, title: Utils.aboutName, builder: (_) => AboutScreen(), animated: animated);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [HomeBar(showAbout: false), Expanded(child: AboutMe()), BottomBar()],
      ),
    );
  }
}

class AboutMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = MediaQuery.of(context).size.width <= 700;
    return Container(
      width: size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: isMobile ? 20 : 150, right: isMobile ? 20 : 150, top: 40),
              child: Text('About Me', style: Utils.h1.copyWith(color: Colors.black)),
            ),
            Padding(
              padding: EdgeInsets.only(left: isMobile ? 20 : 150, right: isMobile ? 20 : 150, top: 40),
              child: Text(
                  'My name is Mariano Zorrilla and I\m a Software Engineer (for the past 10 years), nowadays '
                  'doing Head of Mobile/Tech Lead duties.\n\nFlutter got me super passionate around 2 years ago '
                  'and I use it non stop for every side project, to help the community and inspire developers and non '
                  'developers to use this amazing framework. \n\nIn my free time I do events, meetups, podcasts, '
                  'code challenges and help companies grow faster and better.\n\nIf you wish to know more about '
                  'me, hit the button bellow.\n\nHappy Codding!',
                  style: Utils.h4.copyWith(color: Colors.black)),
            ),
            Padding(
              padding: EdgeInsets.only(left: isMobile ? 20 : 150, right: isMobile ? 20 : 150, top: 40),
              child: OutlineButton(
                onPressed: () {
                  _launchURL('https://mariano-zorrilla.web.app');
                },
                highlightedBorderColor: Colors.grey[700],
                borderSide: BorderSide(color: Colors.black, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('ABOUT ME', style: TextStyle(color: Colors.black, fontSize: 12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
