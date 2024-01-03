class ChannelModel {
  int? statusCode;
  String? message;
  Data? data;

  ChannelModel({this.statusCode, this.message, this.data});

  ChannelModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? name;
  String? description;
  String? image;
  String? bannerImage;
  String? status;
  String? createdAt;
  String? updatedAt;
  dynamic subscriberCount;

  Data(
      {this.id,
        this.userId,
        this.name,
        this.description,
        this.image,
        this.bannerImage,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.subscriberCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    bannerImage = json['bannerImage'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    subscriberCount = json['subscriberCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['bannerImage'] = this.bannerImage;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['subscriberCount'] = this.subscriberCount;
    return data;
  }
}