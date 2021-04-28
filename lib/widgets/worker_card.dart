import 'package:auto_size_text/auto_size_text.dart';
import 'package:beasy_client/models/company_model/company.dart';
import 'package:beasy_client/models/company_model/company_stream.dart';
import 'package:beasy_client/pages/usual_user/worker_info_page.dart';
import 'package:beasy_client/utils/style_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WorkerCard extends StatefulWidget {
  CompanyStream companyStream;

  WorkerCard({this.companyStream});

  @override
  _WorkerCardState createState() => _WorkerCardState();
}

class _WorkerCardState extends State<WorkerCard> {
  DateTime _selectedTimeStart = DateTime.now();
  DateTime curentTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (contex) => WorkerInfoPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: Colors.grey, width: 0.5)),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                width: 50,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    image: DecorationImage(
                        image: AssetImage("assets/user_photo.jpg"),
                        fit: BoxFit.cover)),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          widget.companyStream.streamName ?? "Tomas Shelby",
                          style: TextStyle(
                              color: newColor4,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        child: Text(
                          widget.companyStream.streamDescription ??
                              "I am specialist automecanic.I must do your car  faster",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      RatingBar.builder(
                        updateOnDrag: false,
                        itemSize: 15,
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // Flexible(
              //     child: Container(
              //   margin: EdgeInsets.symmetric(vertical: 5),
              //   child: CustumButton(
              //     onTap: () {
              //       // Navigator.of(context).pushReplacementNamed(InfoWorker.routeName);
              //     },
              //     text: "Show Info",
              //   ),
              // )),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _selectTimeStart(BuildContext context) async {
    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedTimeStart),
    );

    if (time != null) {
      setState(() {
        _selectedTimeStart = DateTime(curentTime.year, curentTime.month,
            curentTime.day, time.hour, time.minute);
      });
    }
  }

  Widget _selectTime() {
    return GestureDetector(
      onTap: () {
        _selectTimeStart(context);
      },
      child: Container(
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        padding: EdgeInsets.only(left: 15, right: 15),
        height: 45,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${_selectedTimeStart.hour}:${_selectedTimeStart.minute}",
              style: TextStyle(fontSize: 15, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Icon(
              Icons.schedule,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //scrollable: true,
      backgroundColor: Color.fromRGBO(50, 65, 85, 1),
      title: Row(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(65)),
                image: DecorationImage(
                    image: AssetImage("assets/user_photo.jpg"),
                    fit: BoxFit.cover)),
          ),
          Text(
            "Join a Queue",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_selectTime()],
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
