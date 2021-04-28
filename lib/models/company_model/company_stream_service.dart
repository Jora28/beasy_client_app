class CompanyStreamService {
  final String companyStreamServiceId;
  String serviceName;
  int durationInMinutes;

  CompanyStreamService({
    this.companyStreamServiceId,
    this.durationInMinutes,
    this.serviceName,
  });

  factory CompanyStreamService.fromJson(json) {
    return CompanyStreamService(
      companyStreamServiceId: json["companyStreamServiceId"],
      durationInMinutes: json["durationInMinutes"],
      serviceName: json["serviceName"],
    );
  }

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();
    data["durationInMinutes"] = this.durationInMinutes;
    data["serviceName"] = this.serviceName;
    data["companyStreamServiceId"] = this.companyStreamServiceId;
    return data;
  }
}
