class PinPointModel {
  String? id;
  String? trackId;
  String? name;
  String? lat;
  String? lon;
  dynamic distanceInKm;
  dynamic serialNumber;
  String? feature;
  String? text;
  String? sound;
  String? image;
  String? video;
  String? createdAt;
  String? updatedAt;
  PreviewComment? previewComment;

  PinPointModel(
      {this.id,
        this.trackId,
        this.name,
        this.lat,
        this.lon,
        this.distanceInKm,
        this.serialNumber,
        this.feature,
        this.text,
        this.sound,
        this.image,
        this.video,
        this.createdAt,
        this.updatedAt,
      this.previewComment});

  PinPointModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trackId = json['trackId'];
    name = json['name'];
    lat = json['lat'];
    lon = json['lon'];
    distanceInKm = json['distanceInKm'];
    serialNumber = json['serialNumber'];
    feature = json['feature'];
    text = json['text'];
    sound = json['sound'];
    image = json['image'];
    video = json['video'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    previewComment = json['previewComment'] != null ? new PreviewComment.fromJson(json['previewComment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trackId'] = this.trackId;
    data['name'] = this.name;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['distanceInKm'] = this.distanceInKm;
    data['serialNumber'] = this.serialNumber;
    data['feature'] = this.feature;
    data['text'] = this.text;
    data['sound'] = this.sound;
    data['image'] = this.image;
    data['video'] = this.video;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.previewComment != null) {
      data['previewComment'] = this.previewComment!.toJson();
    }
    return data;
  }
}



class PreviewComment {
  String? id;
  String? pinPointId;
  String? trackId;
  String? userId;
  String? text;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? reactionsCount;
  Reactions? reactions;
  User? user;
  bool? isReacted;
  int? repliesCount;

  PreviewComment({this.id,  this.pinPointId, this.trackId, this.userId, this.text, this.status,  this.createdAt, this.updatedAt, this.reactionsCount, this.reactions, this.user, this.isReacted, this.repliesCount});

  PreviewComment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pinPointId = json['pinPointId'];
    trackId = json['trackId'];
    userId = json['userId'];
    text = json['text'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    reactionsCount = json['reactionsCount'];
    reactions = json['reactions'] != null ? new Reactions.fromJson(json['reactions']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    isReacted = json['isReacted'];
    repliesCount = json['repliesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pinPointId'] = this.pinPointId;
    data['trackId'] = this.trackId;
    data['userId'] = this.userId;
    data['text'] = this.text;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['reactionsCount'] = this.reactionsCount;
    if (this.reactions != null) {
      data['reactions'] = this.reactions!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['isReacted'] = this.isReacted;
    data['repliesCount'] = this.repliesCount;
    return data;
  }
}



class Reactions {
  String? id;
  String? trackId;
  String? commentId;
  String? userId;
  String? type;
  String? createdAt;
  String? updatedAt;

  Reactions({this.id, this.trackId, this.commentId, this.userId, this.type, this.createdAt, this.updatedAt});

  Reactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trackId = json['trackId'];
    commentId = json['commentId'];
    userId = json['userId'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trackId'] = this.trackId;
    data['commentId'] = this.commentId;
    data['userId'] = this.userId;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
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