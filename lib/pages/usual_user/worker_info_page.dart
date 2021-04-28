import 'package:beasy_client/utils/style_color.dart';
import 'package:beasy_client/widgets/buttons.dart';
import 'package:flutter/material.dart';

class WorkerInfoPage extends StatefulWidget {
  static final routeName = 'WorkerInfoPage';
  WorkerInfoPage({Key key}) : super(key: key);

  @override
  _WorkerInfoPageState createState() => _WorkerInfoPageState();
}

class _WorkerInfoPageState extends State<WorkerInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        Flexible(
         // flex: 2,
         // height: MediaQuery.of(context).size.height * 0.88,
          child: ListView(
            padding: EdgeInsets.only(bottom:70),
            shrinkWrap: true,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage('assets/user_photo.jpg'),
                            fit: BoxFit.cover)),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 15, top: 15, bottom: 15),
                child: Text("Tomas Shelby",
                    style: TextStyle(
                        color: newColor4,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text("Specialic Automecanic",
                    style: TextStyle(
                        color: newColor4.withOpacity(0.7),
                        fontSize: 18,
                        fontWeight: FontWeight.normal)),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Text("Experience"),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text("4 year",
                                  style: TextStyle(
                                      color: newColor4,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700)),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text("Rating"),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text("4.5",
                                  style: TextStyle(
                                      color: newColor4,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700)),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(left: 15, top: 15, bottom: 15),
                child: Text("About",
                    style: TextStyle(
                        color: newColor4,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                    "A simple yet fully customizable ratingbar for flutter which also include a rating bar indicator, supporting any fraction of rating.",
                    style: TextStyle(
                        color: newColor4.withOpacity(0.7),
                        fontSize: 18,
                        fontWeight: FontWeight.normal)),
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                    "A simple yet fully customizable ratingbar for flutter which also include a rating bar indicator, supporting any fraction of rating.",
                    style: TextStyle(
                        color: newColor4.withOpacity(0.7),
                        fontSize: 18,
                        fontWeight: FontWeight.normal)),
              ),
            ],
          ),
        ),
        Flexible(
                  child: Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(offset: Offset(1,1),color: Colors.black,blurRadius: 5)
                      ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: CustumButton(text: "Book an Appointment", onTap: () {}),
              ),
            ),
          ),
        ),
        Positioned(
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          top: 40,
          left: 20,
        )
      ],
    );
  }
}
