class InquiryModel {
  int? statusCode;
  String? message;
  Data? data;

  InquiryModel({this.statusCode, this.message, this.data});

  InquiryModel.fromJson(Map<String, dynamic> json) {
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
  Inquiry? inquiry;

  Data({this.inquiry});

  Data.fromJson(Map<String, dynamic> json) {
    inquiry =
    json['inquiry'] != null ? new Inquiry.fromJson(json['inquiry']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.inquiry != null) {
      data['inquiry'] = this.inquiry!.toJson();
    }
    return data;
  }
}

class Inquiry {
  String? id;
  String? title;
  String? description;
  String? type;
  String? userId;
  String? status;
  String? updatedAt;
  String? createdAt;

  Inquiry(
      {this.id,
        this.title,
        this.description,
        this.type,
        this.userId,
        this.status,
        this.updatedAt,
        this.createdAt});

  Inquiry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    userId = json['userId'];
    status = json['status'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['type'] = this.type;
    data['userId'] = this.userId;
    data['status'] = this.status;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}