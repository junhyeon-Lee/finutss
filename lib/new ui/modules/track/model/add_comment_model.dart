class AddCommentModel {
  int? statusCode;
  String? message;
  Data? data;

  AddCommentModel({this.statusCode, this.message, this.data});

  AddCommentModel.fromJson(Map<String, dynamic> json) {
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
  String? status;
  String? pinPointId;
  String? text;
  String? attachment;
  String? trackId;
  String? userId;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.id,
        this.status,
        this.pinPointId,
        this.text,
        this.attachment,
        this.trackId,
        this.userId,
        this.updatedAt,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    pinPointId = json['pinPointId'];
    text = json['text'];
    attachment = json['attachment'];
    trackId = json['trackId'];
    userId = json['userId'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['pinPointId'] = this.pinPointId;
    data['text'] = this.text;
    data['attachment'] = this.attachment;
    data['trackId'] = this.trackId;
    data['userId'] = this.userId;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}