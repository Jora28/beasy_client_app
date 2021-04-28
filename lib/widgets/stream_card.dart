import 'package:auto_size_text/auto_size_text.dart';
import 'package:beasy_client/models/company_model/company.dart';
import 'package:beasy_client/pages/usual_user/company_info_page.dart';
import 'package:beasy_client/pages/usual_user/stream_info_page.dart';
import 'package:beasy_client/utils/style_color.dart';
import 'package:flutter/material.dart';

class StreamsCard extends StatefulWidget {
  Company company;

  StreamsCard({this.company});

  @override
  _StreamsCardState createState() => _StreamsCardState();
}

class _StreamsCardState extends State<StreamsCard> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white,
         // boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 0.5)],
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.grey, width: 0.6)
         ),
      child: InkWell(
        onTap: () {
         Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => StreamInfo(
                    company: widget.company,
                  )));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Flexible(
                flex: 4,
                child: Row(
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
                    Flexible(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.company.companyName ??"Matikyan Dental",
                              style: TextStyle(
                                  color: newColor4,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              child: Text(
                                widget.company.companyDescription??"Dental Clinic",
                                style: TextStyle(
                                    color: newColor4.withOpacity(0.7),
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            AutoSizeText(
                              widget.company.workDays.join(',')??" ",
                              style: TextStyle(
                                  color: newColor4.withOpacity(0.7),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              widget.company.startTime.hour.toString() +":"+widget.company.startTime.minute.toString()
                             +"-"+ 
                             widget.company.endTime.hour.toString() +":"+ widget.company.endTime.minute.toString(),
                              style: TextStyle(
                                  color: newColor4.withOpacity(0.7),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (value == false) {
                        value = !value;
                        // FavoriteCompanies.inserWidget(Text("111"));
                        // print(FavoriteCompanies.faforiteList);
                      } else {
                        value = !value;
                        // FavoriteCompanies.deletWidget();
                        // print(FavoriteCompanies.faforiteList);
                      }
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      value ? Icons.star : Icons.star_border_outlined,
                      size: 30,
                      color: value ? newColor4 :newColor4,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
