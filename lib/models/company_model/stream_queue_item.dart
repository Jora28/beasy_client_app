class StreamQueueItem {
  final DateTime startTime;
  final DateTime endTime;

  StreamQueueItem({
    this.endTime,
    this.startTime,
  });

  factory StreamQueueItem.fromJson(json) {
    return StreamQueueItem(
      startTime: DateTime.parse(json["startTime"]),
      endTime: DateTime.parse(json["endTime"]),
    );
  }

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();

    data["startTime"] = this.startTime.toString();
    data["endTime"] = this.endTime.toString();

    return data;
  }
}
