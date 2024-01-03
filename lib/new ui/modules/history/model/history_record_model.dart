class HistoryRecordModel{
  int? statusCode;
  String? message;
  Data? data;

  HistoryRecordModel({this.statusCode, this.message, this.data});

  HistoryRecordModel.fromJson(Map<String, dynamic> json) {
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
  List<RecordsArray>? recordsArray;
  int? count;

  Data({this.recordsArray, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['recordsArray'] != null) {
      recordsArray = <RecordsArray>[];
      json['recordsArray'].forEach((v) {
        recordsArray!.add(new RecordsArray.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recordsArray != null) {
      data['recordsArray'] = this.recordsArray!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class RecordsArray {
  String? id;
  String? userId;
  String? trackId;
  String? type;
  String? status;
  dynamic exerciseTimeInMin;
  dynamic burnedCal;
  dynamic distanceInKm;
  String? finishedAt;
  String? createdAt;
  String? updatedAt;
  Track? track;

  RecordsArray(
      {this.id,
        this.userId,
        this.trackId,
        this.type,
        this.status,
        this.exerciseTimeInMin,
        this.burnedCal,
        this.distanceInKm,
        this.finishedAt,
        this.createdAt,
        this.updatedAt,
        this.track});

  RecordsArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    trackId = json['trackId'];
    type = json['type'];
    status = json['status'];
    exerciseTimeInMin = json['exerciseTimeInMin'];
    burnedCal = json['burnedCal'];
    distanceInKm = json['distanceInKm'];
    finishedAt = json['finishedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    track = json['track'] != null ? new Track.fromJson(json['track']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['trackId'] = this.trackId;
    data['type'] = this.type;
    data['status'] = this.status;
    data['exerciseTimeInMin'] = this.exerciseTimeInMin;
    data['burnedCal'] = this.burnedCal;
    data['distanceInKm'] = this.distanceInKm;
    data['finishedAt'] = this.finishedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.track != null) {
      data['track'] = this.track!.toJson();
    }
    return data;
  }
}

class Track {
  String? id;
  String? name;

  Track({this.id, this.name});

  Track.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}