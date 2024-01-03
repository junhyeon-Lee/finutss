class ChatMessageModel{
  int? statusCode;
  String? message;
  Data? data;

  ChatMessageModel({this.statusCode, this.message, this.data});

  ChatMessageModel.fromJson(Map<String, dynamic> json) {
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
  String? createdAt;
  String? updatedAt;
  ChatMessages? chatMessages;

  Data(
      {this.id,
        this.trackId,
        this.createdAt,
        this.updatedAt,
        this.chatMessages});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trackId = json['trackId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    chatMessages = json['chatMessages'] != null
        ? new ChatMessages.fromJson(json['chatMessages'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trackId'] = this.trackId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.chatMessages != null) {
      data['chatMessages'] = this.chatMessages!.toJson();
    }
    return data;
  }
}

class ChatMessages {
  int? count;
  List<Rows>? rows;

  ChatMessages({this.count, this.rows});

  ChatMessages.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(new Rows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rows {
  String? id;
  String? chatId;
  String? userId;
  String? contentType;
  String? content;
  String? createdAt;
  String? updatedAt;
  User? user;

  Rows(
      {this.id,
        this.chatId,
        this.userId,
        this.contentType,
        this.content,
        this.createdAt,
        this.updatedAt,
        this.user});

  Rows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatId = json['chatId'];
    userId = json['userId'];
    contentType = json['contentType'];
    content = json['content'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chatId'] = this.chatId;
    data['userId'] = this.userId;
    data['contentType'] = this.contentType;
    data['content'] = this.content;
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
  String? firstName;
  String? lastName;
  String? username;
  String? profilePhoto;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.profilePhoto});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    profilePhoto = json['profilePhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
    data['profilePhoto'] = this.profilePhoto;
    return data;
  }
}