import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttergallery/items/sample_item.dart';
import 'package:fluttergallery/utils/widgets.dart';
import 'package:universal_html/html.dart';
import 'package:flutter/material.dart';
import 'package:fluttergallery/model/sample.dart';
import 'package:fluttergallery/utils/simple_route.dart';
import 'package:fluttergallery/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  static Route<dynamic> route(bool animated) {
    return SimpleRoute(name: Utils.appPath, title: Utils.appName, builder: (_) => HomeScreen(), animated: animated);
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [HomeBar(showAbout: true), Expanded(child: SearchGallery()), BottomBar()],
      ),
    );
  }
}

class SearchGallery extends StatefulWidget {
  @override
  _SearchGalleryState createState() => _SearchGalleryState();
}

class _SearchGalleryState extends State<SearchGallery> {
  final _controller = TextEditingController();
  final List<Sample> _list = [];
  final List<Sample> _filteredList = [];

  @override
  void initState() {
    super.initState();
    fetchData().then((list) => setState(() {
          _list.addAll(list);
          _filteredList.addAll(_list);
        }));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<List<Sample>> fetchData() async {
    final json = await HttpRequest.getString('${Utils.rootUrl}assets/samples.json');
    final decode = await jsonDecode(json) as List;
    return decode.map((item) => Sample.toObject(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 700;
    final isTablet = MediaQuery.of(context).size.width > 700 && MediaQuery.of(context).size.width < 1000;
    return Padding(
      padding: EdgeInsets.only(left: isMobile ? 20 : 150, right: isMobile ? 20 : 150, top: 40),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('All Samples', style: Utils.h1.copyWith(color: Colors.black)),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                  'Curated list of Flutter clones. These samples are made in love and homage to the original sites;'
                      ' all trademarks are those of the respective owners.',
                  style: Utils.h5.copyWith(color: Colors.black)),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                suffixIcon: _controller.text.isNotEmpty
                    ? InkResponse(
                        onTap: () {
                          _controller.clear();
                          setState(() {
                            _filteredList.clear();
                            _filteredList.addAll(_list);
                          });
                        },
                        child: Icon(Icons.close, color: Theme.of(context).primaryColor),
                      )
                    : null,
              ),
              onChanged: (text) {
                setState(() {
                  _filteredList.clear();
                  _filteredList.addAll(_list.where((item) =>
                      item.title.toLowerCase().contains(_controller.text.toLowerCase()) ||
                      item.clone.toLowerCase().contains(_controller.text.toLowerCase()) ||
                      item.description.toLowerCase().contains(_controller.text.toLowerCase())));
                });
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 40),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.2, crossAxisCount: isTablet ? 2 : isMobile ? 1 : 3),
              itemBuilder: (context, index) {
                return SampleItem(sample: _filteredList[index]);
              },
              itemCount: _filteredList.length,
            ),
          )
        ],
      ),
    );
  }
}
