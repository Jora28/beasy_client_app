import 'package:beasy_client/models/company_model/company.dart';
import 'package:beasy_client/models/company_model/company_stream.dart';
import 'package:beasy_client/models/company_model/stream_queue_item.dart';
import 'package:beasy_client/pages/usual_user/worker_info_page.dart';
import 'package:beasy_client/services/beasyApi.dart';
import 'package:beasy_client/utils/helpers.dart';
import 'package:beasy_client/utils/style_color.dart';
import 'package:beasy_client/widgets/buttons.dart';
import 'package:beasy_client/widgets/dialog.dart';
import 'package:beasy_client/widgets/inpurs.dart';
import 'package:day_picker/model/day_in_week.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class BookPage extends StatefulWidget {
  static final routeName = 'BookPage';
  final CompanyStream companyStream;
  final String companyOwnerId;
  final Company company;

  BookPage({this.companyStream, this.companyOwnerId, this.company});

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  List<StreamQueueItem> listQueueItem = [];
  List<StreamQueueItem> availibalTime = [];
  List<WeekDay> workDays = [];
  int selectedtItemInShowDialog = 0;
  var selectedtItem;
  DateTime _selectedTimeStart = DateTime.now();
  DateTime curentTime = DateTime.now();
  TimeOfDay time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(),
    );
  }

  getDays() {
    var date = DateTime.now();

    print("Start day of week");

    var start = date.subtract(Duration(days: date.weekday - 1)).day.toString();
    print(start);
    for (int i = 0; i < 7; i++) {
      var day = date.subtract(Duration(days: date.weekday - i)).day.toString();
      var dayN = date.subtract(Duration(days: date.weekday - i));
      var dayName =
          DateFormat('EEEE').format(dayN).substring(0, 3).toUpperCase();
      workDays.add(WeekDay(dayNumber: day, dayName: dayName));
    }
    print("this is ${workDays[0].dayName}");
  }

  @override
  void initState() {
    getDays();
    selectedtItem = workDays[0].dayName;
    super.initState();
  }

  Widget _body() {
    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.only(bottom: 100),
          shrinkWrap: true,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      child: Text(
                    "Details",
                    style: TextStyle(
                        color: newColor4,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/user_photo.jpg')),
                  ),
                  Container(
                    child: Text(
                      "Tomas Shelby",
                      style: TextStyle(
                          color: newColor4,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(child: Text("Specialist Automecanic")),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 40, left: 20),
                    child: Text(
                      "Day your book",
                      style: TextStyle(
                          fontSize: 16, color: newColor4.withOpacity(1)),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 70,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                          children: workDays.map((day) {
                        return Expanded(
                          child: _selectWorkDay(
                              day: day.dayNumber, weekDayName: day.dayName),
                        );
                      }).toList())),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "Working Time",
                      style: TextStyle(
                          fontSize: 16, color: newColor4.withOpacity(1)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 20, bottom: 20),
                    child: Text(
                      widget.company.startTime.hour.toString() +
                          ":" +
                          widget.company.startTime.minute.toString() +
                          " - " +
                          widget.company.endTime.hour.toString() +
                          ":" +
                          widget.company.endTime.minute.toString(),
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "Time your book",
                      style: TextStyle(
                          fontSize: 16, color: newColor4.withOpacity(1)),
                    ),
                  ),
                  _selectWorkTime(),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: newColor4,
                        borderRadius: BorderRadius.circular(25)),
                    child: Icon(Icons.call, color: Colors.white),
                  )
                ],
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Container(
                      child: Text(
                        "Back",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      offset: Offset(1, 1), color: Colors.black, blurRadius: 5)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: CustumButton(
                  text: "Book an Appointment",
                  onTap: () async {
                    print(widget.companyOwnerId);
                    if (time != null) {
                      var dateOfTime = timeOfDaytoDate(time);

                      var isAvailibaleQueue =
                          await BeasyApi().companyServices.bookAStream(
                                compmayId: widget.companyOwnerId,
                                streamId: widget.companyStream.companyStreamId,
                                queueItem: StreamQueueItem(
                                    startTime: dateOfTime,
                                    endTime: dateOfTime.add(Duration(
                                      minutes: widget.companyStream
                                          .streamServices[0].durationInMinutes,
                                    ))),
                              );
                      if (isAvailibaleQueue) {
                        print("You can booking in this time");
                        showAlertDialog(
                            title: "Thank yor are booking",
                            text:
                                "Your booking ${dateOfTime.hour}:${dateOfTime.minute}");
                      } else {
                        print("Sorry you can`t booking at this time :((((");
                        await getAvailibaleTime();
                        showAlertDialog(
                            title: "Sorry you can`t booking at this time :((((",
                            text: "Please select availibale time");
                      }
                    } else {
                      Fluttertoast.showToast(
                        msg: "Please select time",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 16,
                      );
                    }
                  }),
            ),
          ),
        ),
      ],
    );
  }

  getAvailibaleTime() async {
    var availibale = await BeasyApi().companyServices.getAvailibaleTime(
          compmayId: widget.companyOwnerId,
          streamId: widget.companyStream.companyStreamId,
        );

    for (int i = 0; i < availibale.length; i++) {
      listQueueItem.add(StreamQueueItem(
          startTime: availibale[i].startTime, endTime: availibale[i].endTime));
      print("Start: ${listQueueItem[i].startTime}");
      print("End: ${listQueueItem[i].endTime}");
    }
    var lastTime = availibale.last.endTime;

    print("last time:${lastTime.hour}");
    print("wotking time end${widget.company.endTime.hour}");
    var x = widget.company.endTime.hour;
    var y = lastTime.hour;
    var endTime = lastTime.add(Duration(
      minutes: widget.companyStream.streamServices[0].durationInMinutes,
    ));
    while (x > y) {
      var a = StreamQueueItem(startTime: lastTime, endTime: endTime);

      if (endTime.hour != widget.company.endTime.hour) {
        availibalTime.add(a);
        lastTime = endTime.add(Duration(
          minutes: widget.companyStream.streamServices[0].durationInMinutes,
        ));
        endTime = lastTime.add(Duration(
          minutes: widget.companyStream.streamServices[0].durationInMinutes,
        ));
        ++y;
      } else {
        break;
      }
    }
    for (int i = 0; i < availibalTime.length; i++) {
      print("avilibale:${availibalTime[i].startTime}");
      print("availibale:12${availibalTime[i].endTime}");
    }
  }

  showAlertDialog({String title, String text}) {
    Widget okButton = Container(
        height: 40,
        width: 60,
        child: CustumButton(
          text: "OK",
          onTap: () {
            availibalTime = [];
            Navigator.of(context).pop();
          },
        ));

    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.all(10),
      scrollable: true,
      backgroundColor: Colors.white,
      title: Container(
        margin: EdgeInsets.all(5),
        child: Text(title),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text),
            Expanded(
              child: Container(
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: availibalTime.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: newColor4, width: 0.5)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(availibalTime[index]
                                      .startTime
                                      .hour
                                      .toString() +
                                  ":" +
                                  availibalTime[index]
                                      .startTime
                                      .minute
                                      .toString() +
                                  "-" +
                                  availibalTime[index].endTime.hour.toString() +
                                  ":" +
                                  availibalTime[index]
                                      .endTime
                                      .minute
                                      .toString()),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  selectedItem(cardTitele) {
    setState(() {
      selectedtItem = cardTitele;
    });
  }

  Widget _selectWorkDay({String day, String weekDayName}) {
    return GestureDetector(
      onTap: () {
        selectedItem(day);
        print(day);
      },
      child: Column(
        children: [
          Container(
            child: Text(
              weekDayName,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: day == selectedtItem ? newColor4 : Colors.white,
                borderRadius: BorderRadius.circular(40)),
            child: Center(
                child: Text(day,
                    style: TextStyle(
                      color: day == selectedtItem ? Colors.white : Colors.black,
                    ))),
          )
        ],
      ),
    );
  }

  Future<Null> _selectTimeStart(BuildContext context) async {
    time = await showTimePicker(
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

  Widget _selectWorkTime() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: GestureDetector(
        onTap: () {
          _selectTimeStart(context);
        },
        child: Container(
          margin: EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
              color: newColor4,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          padding: EdgeInsets.only(left: 15, right: 15),
          height: 45,
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Start  ${_selectedTimeStart.hour}:${_selectedTimeStart.minute}",
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
      ),
    );
  }
}

class WeekDay {
  String dayName;
  String dayNumber;
  WeekDay({this.dayName, this.dayNumber});
}
