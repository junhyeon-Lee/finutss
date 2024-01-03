class TodayRecordModel {
  int? statusCode;
  String? message;
  Data? data;

  TodayRecordModel({this.statusCode, this.message, this.data});

  TodayRecordModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  TodayRecord? todayRecord;

  Data({this.todayRecord});

  Data.fromJson(Map<String, dynamic> json) {
    todayRecord = json['todayRecord'] != null
        ? new TodayRecord.fromJson(json['todayRecord'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.todayRecord != null) {
      data['todayRecord'] = this.todayRecord!.toJson();
    }
    return data;
  }
}

class TodayRecord {
  String? id;
  String? userId;
  String? trackId;
  String? type;
  String? status;
  int? burnedCal;
  int? distance;
  String? finishedAt;
  String? createdAt;
  String? updatedAt;

  TodayRecord(
      {this.id,
        this.userId,
        this.trackId,
        this.type,
        this.status,
        this.burnedCal,
        this.distance,
        this.finishedAt,
        this.createdAt,
        this.updatedAt});

  TodayRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    trackId = json['trackId'];
    type = json['type'];
    status = json['status'];
    burnedCal = json['burnedCal'];
    distance = json['distance'];
    finishedAt = json['finishedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['trackId'] = this.trackId;
    data['type'] = this.type;
    data['status'] = this.status;
    data['burnedCal'] = this.burnedCal;
    data['distance'] = this.distance;
    data['finishedAt'] = this.finishedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}