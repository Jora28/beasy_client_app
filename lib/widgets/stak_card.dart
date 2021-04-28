import 'package:beasy_client/models/company_model/company_stream.dart';
import 'package:beasy_client/services/beasyApi.dart';
import 'package:beasy_client/utils/style_color.dart';
import 'package:flutter/material.dart';

class StackCard extends StatefulWidget {
  CompanyStream companyStream = CompanyStream();

  StackCard({this.companyStream});

  @override
  _StackCardState createState() => _StackCardState();
}

class _StackCardState extends State<StackCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.grey, width: 0.5)),
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(5),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(65)),
                        image: DecorationImage(
                            image: AssetImage("assets/user_photo.jpg"),
                            fit: BoxFit.cover)),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.companyStream.streamName ?? "hhh",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        widget.companyStream.streamDescription ??
                            "description ",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "on/off Stack",
                    textAlign: TextAlign.center,
                  ),
                  margin: EdgeInsets.only(top: 5),
                ),
                Switch(
                  activeColor: newColor4,
                  value:widget.companyStream.companyStreamState,
                  onChanged: (value) {
                    BeasyApi()
                        .companyServices
                        .switchStreamState(toValue: value, streamId: widget.companyStream.companyStreamId);
                    setState(() {
                      widget.companyStream.companyStreamState = value;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
