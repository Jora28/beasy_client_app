
import 'package:beasy_client/models/company_model/stream_queue_item.dart';

import 'company_stream_service.dart';

class CompanyStream {
  String companyStreamId;
  String streamName;
  String streamDescription;
  bool companyStreamState;
  final List<String> streamImages;
  List<StreamQueueItem> queue = [];
  List<CompanyStreamService> streamServices = [];

  CompanyStream({
    this.companyStreamId,
    this.streamImages,
    this.streamName,
    this.streamServices,
    this.streamDescription,
    this.companyStreamState = false,
  });

  factory CompanyStream.fromJson(json) {
    return CompanyStream(
      companyStreamId: json["companyStreamId"],
      streamName: json["streamName"],
      streamDescription: json["streamDescription"],
      streamImages: json["streamImages"] != null
          ? (json["streamImages"] as List).map((e) => e.toString()).toList()
          : null,
      streamServices: json["streamServices"] != null
          ? (json["streamServices"] as List)
              .map((element) => CompanyStreamService.fromJson(element))
              .toList()
          : null,
      companyStreamState: json["companyStreamState"] != null
          ? json["companyStreamState"] as bool
          : false,
    );
  }

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();

    data["companyStreamId"] = this.companyStreamId;

    data["streamName"] = this.streamName;
    data["streamDescription"] = this.streamDescription;
    data["streamImages"] = this.streamImages;
    data["streamServices"] = this.streamServices != null
        ? this.streamServices.map((e) => e.toJson()).toList()
        : null;
    data["companyStreamState"] =
        this.companyStreamState != null ? this.companyStreamState : false;
    return data;
  }
}
