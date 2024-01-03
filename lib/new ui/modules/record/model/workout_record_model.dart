class WorkoutRecordModel {
  int? statusCode;
  String? message;
  Data? data;

  WorkoutRecordModel({this.statusCode, this.message, this.data});

  WorkoutRecordModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? trackId;
  String? type;
  String? userId;
  dynamic burnedCal;
  dynamic? exerciseTimeInMin;
  dynamic distanceInKm;
  String? status;
  String? updatedAt;
  String? createdAt;
  String? walletTransactionId;

  Data(
      {this.id,
        this.trackId,
        this.type,
        this.userId,
        this.burnedCal,
        this.exerciseTimeInMin,
        this.distanceInKm,
        this.status,
        this.updatedAt,
        this.walletTransactionId,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trackId = json['trackId'];
    type = json['type'];
    userId = json['userId'];
    burnedCal = json['burnedCal'];
    walletTransactionId = json['walletTransactionId'];
    distanceInKm = json['distanceInKm'];
    status = json['status'];
    updatedAt = json['updatedAt'];
    exerciseTimeInMin = json['exerciseTimeInMin'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trackId'] = this.trackId;
    data['type'] = this.type;
    data['userId'] = this.userId;
    data['burnedCal'] = this.burnedCal;
    data['exerciseTimeInMin'] = this.exerciseTimeInMin;
    data['distanceInKm'] = this.distanceInKm;
    data['status'] = this.status;
    data['updatedAt'] = this.updatedAt;
    data['walletTransactionId'] = this.walletTransactionId;
    data['createdAt'] = this.createdAt;
    return data;
  }
}