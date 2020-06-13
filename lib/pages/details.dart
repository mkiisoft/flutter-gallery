import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttergallery/model/sample.dart';
import 'package:fluttergallery/pages/home.dart';
import 'package:fluttergallery/utils/simple_route.dart';
import 'package:fluttergallery/utils/extensions.dart';
import 'package:fluttergallery/utils/utils.dart';
import 'package:fluttergallery/utils/widgets.dart';
import 'package:universal_html/html.dart';

class SampleDetails extends StatefulWidget {
  const SampleDetails({Key key, this.path}) : super(key: key);
  final String path;

  static Route<dynamic> route(bool animated, String path) {
    print(path);
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
    final json = await HttpRequest.getString('assets/samples.json');
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
                    child: HomeBar(),
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
  final _controller = PageController(viewportFraction: 0.2);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = MediaQuery.of(context).size.width <= 700;
    return Container(
      width: size.width,
      padding: EdgeInsets.only(left: isMobile ? 20 : 150, right: isMobile ? 20 : 150, top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.sample.title, style: Utils.h1.copyWith(color: Colors.black)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(widget.sample.description, style: Utils.h5.copyWith(color: Colors.black)),
          ),
          PageView.builder(
            controller: _controller,
            itemBuilder: (context, index) {
              final image = widget.sample.screenshots[index];
              return AspectRatio(
                aspectRatio: 0.7,
                child: SizedBox(
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(image, fit: BoxFit.cover),
                  ),
                ),
              );
            },
            itemCount: widget.sample.screenshots.length,
          )
        ],
      ),
    );
  }
}
