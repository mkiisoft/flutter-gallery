import 'dart:convert';
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
        children: [AppBar(), Expanded(child: SearchGallery()), BottomBar()],
      ),
    );
  }
}

class AppBar extends StatelessWidget {
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

class SearchGallery extends StatefulWidget {
  @override
  _SearchGalleryState createState() => _SearchGalleryState();
}

class _SearchGalleryState extends State<SearchGallery> {
  final _controller = TextEditingController();
  final _list = [];

  @override
  void initState() {
    super.initState();
    fetchData().then((value) {
      print(value.length);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<List<Sample>> fetchData() async {
    final json = await jsonDecode('assets/samples.json') as List;
    return json.map((item) => Sample.toObject(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final isTablet = MediaQuery.of(context).size.width < 1000;
    return Padding(
      padding: EdgeInsets.only(left: isMobile ? 20 : 150, right: isMobile ? 20 : 150, top: 40),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('All Samples', style: Utils.h1.copyWith(color: Colors.black)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('Curated list of Flutter clones.', style: Utils.h5.copyWith(color: Colors.black)),
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
                          setState(() {});
                        },
                        child: Icon(Icons.close, color: Theme.of(context).primaryColor),
                      )
                    : null,
              ),
              onChanged: (text) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 40),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 1.4, crossAxisCount: isTablet ? 2 : 3),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Card(
                    elevation: 5,
                  ),
                );
              },
              itemCount: _list.length,
            ),
          )
        ],
      ),
    );
  }
}
