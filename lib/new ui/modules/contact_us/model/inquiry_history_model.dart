class InquiryHistoryModel {
  int? statusCode;
  String? message;
  Data? data;

  InquiryHistoryModel({this.statusCode, this.message, this.data});

  InquiryHistoryModel.fromJson(Map<String, dynamic> json) {
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
  List<InquiryArray>? inquiryArray;
  int? count;

  Data({this.inquiryArray, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['inquiryArray'] != null) {
      inquiryArray = <InquiryArray>[];
      json['inquiryArray'].forEach((v) {
        inquiryArray!.add(new InquiryArray.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.inquiryArray != null) {
      data['inquiryArray'] = this.inquiryArray!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class InquiryArray {
  String? id;
  String? userId;
  String? type;
  String? title;
  String? description;
  List<Replies>? replies;
  String? status;
  String? createdAt;
  String? updatedAt;

  InquiryArray({this.id,
    this.userId,
    this.type,
    this.title,
    this.description,
    this.replies,
    this.status,
    this.createdAt,
    this.updatedAt});

  InquiryArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['type'] = this.type;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.replies != null) {
      data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}



class Replies {
  String? message;
  String? createdAt;
  String? messageByUserId;

  Replies({this.message, this.createdAt, this.messageByUserId});

  Replies.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    createdAt = json['createdAt'];
    messageByUserId = json['messageByUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['createdAt'] = this.createdAt;
    data['messageByUserId'] = this.messageByUserId;
    return data;
  }
}