class NotificationModel1 {
  String title, name, description, icon;
  bool isRequest;

  NotificationModel1(
      this.title, this.name, this.description, this.icon, this.isRequest);
}

class NotificationModel {
  int? statusCode;
  String? message;
  Data? data;

  NotificationModel({this.statusCode, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
  List<NotificationArray>? notificationArray;
  int? count;

  Data({this.notificationArray, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['notificationArray'] != null) {
      notificationArray = <NotificationArray>[];
      json['notificationArray'].forEach((v) {
        notificationArray!.add(new NotificationArray.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notificationArray != null) {
      data['notificationArray'] =
          this.notificationArray!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class NotificationArray {
  String? id;
  String? userId;
  String? title;
  String? content;
  NotificationData? notificationData;
  String? status;
  String? type;
  String? createdAt;
  String? updatedAt;

  NotificationArray(
      {this.id,
        this.userId,
        this.title,
        this.content,
        this.notificationData,
        this.status,
        this.type,
        this.createdAt,
        this.updatedAt});

  NotificationArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    content = json['content'];
    notificationData = json['data'] != null ? new NotificationData.fromJson(json['data']) : null;
    status = json['status'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['content'] = this.content;
    if (this.notificationData != null) {
      data['data'] = this.notificationData!.toJson();
    }
    data['status'] = this.status;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class NotificationData {
  String? userId;
  String? profilePhoto;
  String? trackId;
  String? invitedByUserId;

  NotificationData({this.userId, this.profilePhoto,this.trackId, this.invitedByUserId});

  NotificationData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    profilePhoto = json['profilePhoto'];
    trackId = json['trackId'];
    invitedByUserId = json['invitedByUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['profilePhoto'] = this.profilePhoto;
    data['trackId'] = this.trackId;
    data['invitedByUserId'] = this.invitedByUserId;
    return data;
  }
}