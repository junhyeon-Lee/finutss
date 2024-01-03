class LiveUserModel {
  int? statusCode;
  String? message;
  Data? data;

  LiveUserModel({this.statusCode, this.message, this.data});

  LiveUserModel.fromJson(Map<String, dynamic> json) {
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
  dynamic? exerciseTimeInMin;
  int? burnedCal;
  dynamic? distanceInKm;
  String? finishedAt;
  String? createdAt;
  String? updatedAt;
  User? user;


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
        this.user});

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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? gender;
  String? firstName;
  String? lastName;
  String? username;
  String? profilePhoto;
  String? description;
  bool? isFollowing;

  User(
      {this.id,
        this.gender,
        this.firstName,
        this.lastName,
        this.username,
        this.profilePhoto,
        this.description,
        this.isFollowing
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gender = json['gender'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    profilePhoto = json['profilePhoto'];
    description = json['description'];
    isFollowing = json['isFollowing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gender'] = this.gender;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
    data['profilePhoto'] = this.profilePhoto;
    data['description'] = this.description;
    data['isFollowing'] = this.isFollowing;
    return data;
  }
}