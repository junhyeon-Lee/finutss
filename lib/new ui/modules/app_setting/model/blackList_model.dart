class BlackListModel {
  int? statusCode;
  String? message;
  Data? data;

  BlackListModel({this.statusCode, this.message, this.data});

  BlackListModel.fromJson(Map<String, dynamic> json) {
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
  List<BlockedArray>? blockedArray;
  int? count;

  Data({this.blockedArray, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['blockedArray'] != null) {
      blockedArray = <BlockedArray>[];
      json['blockedArray'].forEach((v) {
        blockedArray!.add(new BlockedArray.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.blockedArray != null) {
      data['blockedArray'] = this.blockedArray!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class BlockedArray {
  String? id;
  String? blockerId;
  String? blockedId;
  String? updatedAt;
  Blocked? blocked;
  String? showDate;

  BlockedArray(
      {this.id, this.blockerId, this.blockedId, this.updatedAt, this.blocked,this.showDate});

  BlockedArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    blockerId = json['blockerId'];
    blockedId = json['blockedId'];
    updatedAt = json['updatedAt'];
    blocked =
    json['blocked'] != null ? new Blocked.fromJson(json['blocked']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['blockerId'] = this.blockerId;
    data['blockedId'] = this.blockedId;
    data['updatedAt'] = this.updatedAt;
    if (this.blocked != null) {
      data['blocked'] = this.blocked!.toJson();
    }
    return data;
  }
}

class Blocked {
  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? profilePhoto;

  Blocked(
      {this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.profilePhoto});

  Blocked.fromJson(Map<String, dynamic> json) {
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