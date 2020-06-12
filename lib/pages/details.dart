import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttergallery/model/sample.dart';
import 'package:fluttergallery/utils/simple_route.dart';
import 'package:fluttergallery/utils/extensions.dart';
import 'package:fluttergallery/utils/utils.dart';
import 'package:universal_html/html.dart';

class SampleDetails extends StatefulWidget {
  const SampleDetails({Key key, this.path}) : super(key: key);
  final String path;

  static Route<dynamic> route(bool animated, String path) {
    print(path);
    return SimpleRoute(
        name: '/gallery/app/$path', title: path.capitalize(), builder: (_) => SampleDetails(path: path), animated:
    animated);
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
        print('VALORES: $sample');
        setState(() => _sample = sample);
      });
    }
  }

  Future<Sample> fetchData() async {
    final json = await HttpRequest.getString('${Utils.rootUrl}assets/samples.json');
    final decode = await jsonDecode(json) as List;
    final list = decode.map((item) => Sample.toObject(item)).toList();
    print(list.toString());
    return list.where((element) => element.path == widget.path).first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network('', fit: BoxFit.cover),
    );
  }
}
