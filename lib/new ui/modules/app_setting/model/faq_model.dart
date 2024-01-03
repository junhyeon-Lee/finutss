class FaqModel {
  int? statusCode;
  String? message;
  Data? data;

  FaqModel({this.statusCode, this.message, this.data});

  FaqModel.fromJson(Map<String, dynamic> json) {
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
  List<FaqArray>? faqArray;
  int? count;

  Data({this.faqArray, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['faqArray'] != null) {
      faqArray = <FaqArray>[];
      json['faqArray'].forEach((v) {
        faqArray!.add(new FaqArray.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.faqArray != null) {
      data['faqArray'] = this.faqArray!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class FaqArray {
  String? id;
  String? addedByUserId;
  String? title;
  String? content;
  String? category;
  String? subCategory;
  String? createdAt;
  String? updatedAt;

  FaqArray(
      {this.id,
        this.addedByUserId,
        this.title,
        this.content,
        this.category,
        this.subCategory,
        this.createdAt,
        this.updatedAt});

  FaqArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addedByUserId = json['addedByUserId'];
    title = json['title'];
    content = json['content'];
    category = json['category'];
    subCategory = json['subCategory'];
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
    data['subCategory'] = this.subCategory;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}