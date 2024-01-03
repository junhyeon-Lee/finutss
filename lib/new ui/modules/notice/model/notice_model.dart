class NoticeModel {
  int? statusCode;
  String? message;
  Data? data;

  NoticeModel({this.statusCode, this.message, this.data});

  NoticeModel.fromJson(Map<String, dynamic> json) {
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
  List<NoticeArray>? noticeArray;
  int? count;

  Data({this.noticeArray, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['noticeArray'] != null) {
      noticeArray = <NoticeArray>[];
      json['noticeArray'].forEach((v) {
        noticeArray!.add(new NoticeArray.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.noticeArray != null) {
      data['noticeArray'] = this.noticeArray!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class NoticeArray {
  String? id;
  String? addedByUserId;
  String? title;
  String? content;
  String? category;
  String? status;
  String? createdAt;
  String? updatedAt;

  NoticeArray(
      {this.id,
        this.addedByUserId,
        this.title,
        this.content,
        this.category,
        this.status,
        this.createdAt,
        this.updatedAt});

  NoticeArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addedByUserId = json['addedByUserId'];
    title = json['title'];
    content = json['content'];
    category = json['category'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['addedByUserId'] = this.addedByUserId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['category'] = this.category;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}