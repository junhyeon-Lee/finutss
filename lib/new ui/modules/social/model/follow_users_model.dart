class FollowUsersModel {
  int? statusCode;
  String? message;
  Data? data;

  FollowUsersModel({this.statusCode, this.message, this.data});

  FollowUsersModel.fromJson(Map<String, dynamic> json) {
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
  List<FollowersArray>? followersArray;
  int? followersCount;
  List<FollowingArray>? followingArray;
  int? followingCount;

  Data(
      {this.followersArray,
        this.followersCount,
        this.followingArray,
        this.followingCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['followersArray'] != null) {
      followersArray = <FollowersArray>[];
      json['followersArray'].forEach((v) {
        followersArray!.add(new FollowersArray.fromJson(v));
      });
    }
    followersCount = json['followersCount'];
    if (json['followingArray'] != null) {
      followingArray = <FollowingArray>[];
      json['followingArray'].forEach((v) {
        followingArray!.add(new FollowingArray.fromJson(v));
      });
    }
    followingCount = json['followingCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.followersArray != null) {
      data['followersArray'] =
          this.followersArray!.map((v) => v.toJson()).toList();
    }
    data['followersCount'] = this.followersCount;
    if (this.followingArray != null) {
      data['followingArray'] =
          this.followingArray!.map((v) => v.toJson()).toList();
    }
    data['followingCount'] = this.followingCount;
    return data;
  }
}

class FollowersArray {
  String? id;
  String? followerId;
  String? followedId;
  String? createdAt;
  String? updatedAt;
  Follower? follower;
  bool? isFollowing;
  bool? isInvite;

  FollowersArray(
      {this.id,
        this.followerId,
        this.followedId,
        this.createdAt,
        this.updatedAt,
        this.follower,
        this.isFollowing,
        this.isInvite
      });

  FollowersArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    followerId = json['followerId'];
    followedId = json['followedId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    follower = json['follower'] != null
        ? new Follower.fromJson(json['follower'])
        : null;
    isFollowing = json['isFollowing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['followerId'] = this.followerId;
    data['followedId'] = this.followedId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.follower != null) {
      data['follower'] = this.follower!.toJson();
    }
    data['isFollowing'] = this.isFollowing;
    return data;
  }
}

class Follower {
  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? profilePhoto;
  String? description;

  Follower(
      {this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.profilePhoto,
        this.description
      });

  Follower.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    profilePhoto = json['profilePhoto'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
    data['profilePhoto'] = this.profilePhoto;
    data['description'] = this.description;
    return data;
  }
}

class FollowingArray {
  String? id;
  String? followerId;
  String? followedId;
  String? createdAt;
  String? updatedAt;
  Followed? followed;
  bool? isFollowing;
  bool? isInvite;

  FollowingArray(
      {this.id,
        this.followerId,
        this.followedId,
        this.createdAt,
        this.updatedAt,
        this.followed,
        this.isFollowing,
        this.isInvite
      });

  FollowingArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    followerId = json['followerId'];
    followedId = json['followedId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    followed = json['followed'] != null
        ? new Followed.fromJson(json['followed'])
        : null;
    isFollowing = json['isFollowing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['followerId'] = this.followerId;
    data['followedId'] = this.followedId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.followed != null) {
      data['followed'] = this.followed!.toJson();
    }
    data['isFollowing'] = this.isFollowing;
    return data;
  }
}

class Followed {
  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? profilePhoto;
  String? description;

  Followed(
      {this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.profilePhoto,
        this.description
      });

  Followed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    profilePhoto = json['profilePhoto'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
    data['profilePhoto'] = this.profilePhoto;
    data['description'] = this.description;
    return data;
  }
}