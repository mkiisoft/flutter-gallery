import 'package:flutter/material.dart';
import 'package:fluttergallery/model/sample.dart';
import 'package:fluttergallery/pages/details.dart';
import 'package:fluttergallery/utils/utils.dart';

class SampleItem extends StatefulWidget {
  const SampleItem({Key key, this.sample}) : super(key: key);

  final Sample sample;

  @override
  _SampleItemState createState() => _SampleItemState();
}

class _SampleItemState extends State<SampleItem> {
  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width < 1000;
    return Container(
      margin: EdgeInsets.all(isTablet ? 5 : 10),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(SampleDetails.route(true, widget.sample.path));
          },
          child: Stack(
            overflow: Overflow.visible,
            children: [
              Positioned.fill(child: Image.network(widget.sample.image, fit: BoxFit.cover)),
              Column(
                children: [
                  Expanded(child: SizedBox()),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        boxShadow: [BoxShadow(color: Colors.black.withAlpha(0x30), spreadRadius: 5, blurRadius: 8)]),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    child: Column(
                      children: [
                        Text(widget.sample.title,
                            style: isTablet
                                ? Utils.h5.copyWith(color: Colors.black, fontWeight: FontWeight.w500)
                                : Utils.h4.copyWith(color: Colors.black, fontWeight: FontWeight.w500)),
                        Text(widget.sample.description,
                            style: isTablet
                                ? Utils.h6.copyWith(color: Colors.black)
                                : Utils.h5.copyWith(color: Colors.black)),
                      ],
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
