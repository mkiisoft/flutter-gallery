import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttergallery/model/sample.dart';
import 'package:fluttergallery/pages/home.dart';
import 'package:fluttergallery/utils/simple_route.dart';
import 'package:fluttergallery/utils/extensions.dart';
import 'package:fluttergallery/utils/utils.dart';
import 'package:fluttergallery/utils/widgets.dart';
import 'package:photo_view/photo_view.dart';
import 'package:universal_html/html.dart';
import 'package:url_launcher/url_launcher.dart';

class SampleDetails extends StatefulWidget {
  const SampleDetails({Key key, this.path}) : super(key: key);
  final String path;

  static Route<dynamic> route(bool animated, String path) {
    return SimpleRoute(
        name: '/gallery/app/$path',
        title: path.capitalize(),
        builder: (_) => SampleDetails(path: path),
        animated: animated);
  }

  @override
  _SampleDetailsState createState() => _SampleDetailsState();
}

class _SampleDetailsState extends State<SampleDetails> {
  Sample _sample;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      fetchData().then((sample) {
        setState(() => _sample = sample);
      });
    }
  }

  Future<Sample> fetchData() async {
    final json = await HttpRequest.getString('${Utils.rootUrl}assets/samples.json');
    final decode = await jsonDecode(json) as List;
    final list = decode.map((item) => Sample.toObject(item)).toList();
    return list.where((element) => element.path == widget.path).first;
  }

  @override
  Widget build(BuildContext context) {
    return _sample != null
        ? Material(
            child: Column(
              children: [
                GestureDetector(
                    child: HomeBar(showAbout: true),
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(HomeScreen.route(true), (route) => false);
                    }),
                Expanded(child: DetailScreen(sample: _sample)),
                BottomBar(),
              ],
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key key, this.sample}) : super(key: key);

  final Sample sample;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
              padding: EdgeInsets.only(left: isMobile ? 20 : 150, right: isMobile ? 20 : 150, top: 40, bottom: 20),
              child: Row(
                children: [
                  Text(widget.sample.title, style: Utils.h1.copyWith(color: Colors.black)),
                  if (widget.sample.isPWA)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          border: Border.all(color: Utils.pwa, width: 2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text('PWA', style: Utils.h4.copyWith(color: Utils.pwa, fontWeight: FontWeight.bold)),
                      ),
                    )
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: isMobile ? 20 : 150, right: 10, bottom: 30),
                  child: OutlineButton(
                    onPressed: () {
                      _launchURL(widget.sample.demo);
                    },
                    highlightedBorderColor: Colors.grey[700],
                    borderSide: BorderSide(color: Colors.black, width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('LAUNCH APP', style: TextStyle(color: Colors.black, fontSize: 12)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: OutlineButton(
                    onPressed: () {
                      _launchURL(widget.sample.url);
                    },
                    highlightedBorderColor: Colors.grey[700],
                    borderSide: BorderSide(color: Colors.black, width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('< > SOURCE CODE', style: TextStyle(color: Colors.black, fontSize: 12)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 450,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 150),
                itemBuilder: (context, index) {
                  final image = widget.sample.screenshots[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(FullScreenshot.route(true, widget.sample.screenshots, index, widget.sample.path));
                    },
                    child: Container(
                      width: 250,
                      margin: const EdgeInsets.only(right: 25),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(image, fit: BoxFit.cover),
                      ),
                    ),
                  );
                },
                itemCount: widget.sample.screenshots.length,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: isMobile ? 20 : 150, right: isMobile ? 20 : 150, top: 30, bottom: 10),
              child: Text('Description', style: Utils.h2.copyWith(color: Colors.black)),
            ),
            Padding(
              padding: EdgeInsets.only(left: isMobile ? 20 : 150, right: isMobile ? 20 : 150, bottom: 30),
              child: Text(widget.sample.description, style: Utils.h5.copyWith(color: Colors.black)),
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

class FullScreenshot extends StatelessWidget {
  const FullScreenshot({Key key, this.screenshots, this.index}) : super(key: key);

  final List<String> screenshots;
  final int index;

  static Route<dynamic> route(bool animated, List<String> screenshots, int index, String path) {
    return SimpleRoute(
        name: '/gallery/app/$path/image',
        title: Utils.appName,
        builder: (_) => FullScreenshot(screenshots: screenshots, index: index),
        animated: animated,
        solid: false);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Colors.black.withAlpha(0xDD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.close, color: Colors.white, size: 35),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: PageController(initialPage: index),
                itemBuilder: (context, index) {
                  return PhotoView(
                    backgroundDecoration: BoxDecoration(color: Colors.transparent),
                    imageProvider: NetworkImage(screenshots[index]),
                  );
                },
                itemCount: screenshots.length,
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
