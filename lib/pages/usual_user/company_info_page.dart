import 'package:beasy_client/models/company_model/company.dart';
import 'package:beasy_client/models/company_model/stream_queue_item.dart';
import 'package:beasy_client/services/beasyApi.dart';
import 'package:beasy_client/utils/helpers.dart';
import 'package:flutter/material.dart';

class CompanyInfoPage extends StatefulWidget {
  final Company company;

  CompanyInfoPage({this.company});

  @override
  _CompanyInfoPageState createState() => _CompanyInfoPageState();
}

class _CompanyInfoPageState extends State<CompanyInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.company.companyName ?? "something"),
            Container(
              height: 400,
              child: ListView.builder(
                itemBuilder: (c, i) {
                  return InkWell(
                    onTap: () async {
                      var time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(DateTime.now()));
                      var dateOfTime = timeOfDaytoDate(time);
                      await BeasyApi().companyServices.bookAStream(
                            compmayId: widget.company.companyOwnerId,
                            streamId: widget.company.companyStreams[i].companyStreamId,
                            queueItem: StreamQueueItem(
                                startTime: dateOfTime,
                                endTime: dateOfTime.add(Duration(
                                  minutes: widget.company.companyStreams[i]
                                      .streamServices[0].durationInMinutes,
                                ))),
                          );
                    },
                    child: Container(
                      color: Colors.amber,
                      child: ListTile(
                        title:
                            Text(widget.company.companyStreams[i].streamName),
                      ),
                    ),
                  );
                },
                itemCount: widget.company.companyStreams.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
