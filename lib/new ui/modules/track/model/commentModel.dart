class CommentModel {
  int? statusCode;
  String? message;
  Data? data;

  CommentModel({this.statusCode, this.message, this.data});

  CommentModel.fromJson(Map<String, dynamic> json) {
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
  List<CommentArray>? commentArray;
  int? count;

  Data({this.commentArray, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['commentArray'] != null) {
      commentArray = <CommentArray>[];
      json['commentArray'].forEach((v) {
        commentArray!.add(new CommentArray.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commentArray != null) {
      data['commentArray'] = this.commentArray!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class CommentArray {
  String? id;
  Null? parentCommentId;
  String? pinPointId;
  String? trackId;
  String? userId;
  String? text;
  String? status;
  String? attachment;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  User? user;
  List<Replies>? replies;
  int? repliesCount;
  int? reactionsCount;
  bool? isReacted;

  CommentArray(
      {this.id,
      this.parentCommentId,
      this.pinPointId,
      this.trackId,
      this.userId,
      this.text,
      this.status,
      this.attachment,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.user,
      this.replies,
      this.repliesCount,
        this.reactionsCount,
        this.isReacted});

  CommentArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentCommentId = json['parentCommentId'];
    pinPointId = json['pinPointId'];
    trackId = json['trackId'];
    userId = json['userId'];
    text = json['text'];
    status = json['status'];
    attachment = json['attachment'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
    repliesCount = json['repliesCount'];
    reactionsCount = json['reactionsCount'];
    isReacted = json['isReacted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parentCommentId'] = this.parentCommentId;
    data['pinPointId'] = this.pinPointId;
    data['trackId'] = this.trackId;
    data['userId'] = this.userId;
    data['text'] = this.text;
    data['status'] = this.status;
    data['attachment'] = this.attachment;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.replies != null) {
      data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
    data['repliesCount'] = this.repliesCount;
    data['reactionsCount'] = this.reactionsCount;
    data['isReacted'] = this.isReacted;
    return data;
  }
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? profilePhoto;

  User({this.id, this.firstName, this.lastName, this.username, this.profilePhoto});

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

class Replies {
  String? id;
  String? parentCommentId;
  String? pinPointId;
  String? trackId;
  String? userId;
  String? text;
  String? status;
  String? attachment;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  User? user;

  Replies(
      {this.id,
      this.parentCommentId,
      this.pinPointId,
      this.trackId,
      this.userId,
      this.text,
      this.status,
      this.attachment,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.user});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentCommentId = json['parentCommentId'];
    pinPointId = json['pinPointId'];
    trackId = json['trackId'];
    userId = json['userId'];
    text = json['text'];
    status = json['status'];
    attachment = json['attachment'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parentCommentId'] = this.parentCommentId;
    data['pinPointId'] = this.pinPointId;
    data['trackId'] = this.trackId;
    data['userId'] = this.userId;
    data['text'] = this.text;
    data['status'] = this.status;
    data['attachment'] = this.attachment;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
