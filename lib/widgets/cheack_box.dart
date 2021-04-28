import 'package:flutter/material.dart';

class CheackBox extends StatefulWidget {
  final String label;
  bool value;
  Function onT;
  CheackBox({this.label, this.value, this.onT});
  @override
  _CheackBoxState createState() => _CheackBoxState();
}

class _CheackBoxState extends State<CheackBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(children: [
        Container(
          width: 20,
          height: 20,
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: widget.value == true ? Colors.cyan : Colors.white,
              border: Border.all(color: Colors.cyan)),
          child: Container(
              child: Icon(
            Icons.check,
            size: 15.0,
            color: Colors.white,
          )),
        ),
        Container(
            child: Text(
          widget.label,
          style: TextStyle(fontSize: 16, color: Colors.white),
        )),
      ]),
    );
  }
}
