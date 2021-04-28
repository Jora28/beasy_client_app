import 'package:auto_size_text/auto_size_text.dart';
import 'package:beasy_client/models/company_model/company.dart';
import 'package:beasy_client/utils/style_color.dart';
import 'package:beasy_client/widgets/image_slider.dart';
import 'package:beasy_client/widgets/worker_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class StreamInfo extends StatefulWidget {
  final Company company;
  StreamInfo({this.company});

  @override
  _StreamInfoState createState() => _StreamInfoState();
}

class _StreamInfoState extends State<StreamInfo> {
  bool isFaforite = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        BasicDemo(
          isFav: isFaforite,
        ),
        Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
              left: 30,
              right: 30,
              top: MediaQuery.of(context).size.height * 0.38),
          child: AutoSizeText(
            widget.company.companyName,
            style: TextStyle(color: newColor4, fontSize: 25),
            textAlign: TextAlign.start,
          ),
        ),
                Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
              left: 30,
              right: 30,
              top: MediaQuery.of(context).size.height * 0.43),
          child: Text(
            "Staff",
            style: TextStyle(color: Colors.grey, fontSize: 20),
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey,width: 0.5))
          ),
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.48),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.company.companyStreams.length,
              itemBuilder: (context, index) {
                return WorkerCard(
                  companyStream: widget.company.companyStreams[index],
                );
              }),
        ),
      ],
    );
  }
}

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class BasicDemo extends StatefulWidget {
  bool isFav;
  BasicDemo({this.isFav});
  @override
  _BasicDemoState createState() => _BasicDemoState();
}

class _BasicDemoState extends State<BasicDemo> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                viewportFraction: 1.0,
                //enlargeCenterPage: true,
                height: MediaQuery.of(context).size.height * 0.45,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            items: imgList
                .map((item) => Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                item,
                              ),
                              fit: BoxFit.cover)),
                      // child: Image.network(
                      //   item,
                      //   fit: BoxFit.cover,
                      // )
                    ))
                .toList(),
          ),
          Positioned(
              top: 30,
              right: 10,
              child: IconButton(
                icon: Icon(
                    widget.isFav ? Icons.favorite : Icons.favorite_outline,
                    color: Colors.white),
                onPressed: () {
                  setState(() {
                    widget.isFav = !widget.isFav;
                  });
                },
              )),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.map((url) {
                int index = imgList.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index ? newColor4 : Colors.white),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
