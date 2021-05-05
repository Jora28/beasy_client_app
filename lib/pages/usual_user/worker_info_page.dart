import 'package:beasy_client/models/company_model/company.dart';
import 'package:beasy_client/models/company_model/company_stream.dart';
import 'package:beasy_client/pages/usual_user/book_page.dart';
import 'package:beasy_client/utils/style_color.dart';
import 'package:beasy_client/widgets/buttons.dart';
import 'package:flutter/material.dart';

class WorkerInfoPage extends StatefulWidget {
  static final routeName = 'WorkerInfoPage';
  final CompanyStream companyStream;
  final String companyId;
  final Company company;
  WorkerInfoPage({this.companyStream, this.companyId, this.company});

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
          child: ListView(
            padding: EdgeInsets.only(bottom: 100),
            shrinkWrap: true,
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
                child: Text(widget.companyStream.streamName,
                    style: TextStyle(
                        color: newColor4,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(widget.companyStream.streamServices[0].serviceName,
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
                child: Text(widget.companyStream.streamDescription,
                    style: TextStyle(
                        color: newColor4.withOpacity(0.7),
                        fontSize: 18,
                        fontWeight: FontWeight.normal)),
              ),
            ],
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
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BookPage(
                              companyStream: widget.companyStream,
                              companyOwnerId: widget.companyId,
                              company: widget.company,
                            )));
                  }),
            ),
          ),
        ),
        Positioned(
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          top: 30,
          left: 10,
        )
      ],
    );
  }
}
