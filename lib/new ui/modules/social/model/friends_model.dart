class FriendModel {
  int? statusCode;
  String? message;
  Data? data;

  FriendModel({this.statusCode, this.message, this.data});

  FriendModel.fromJson(Map<String, dynamic> json) {
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
  List<UserArray>? userArray;
  int? count;

  Data({this.userArray, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['userArray'] != null) {
      userArray = <UserArray>[];
      json['userArray'].forEach((v) {
        userArray!.add(new UserArray.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userArray != null) {
      data['userArray'] = this.userArray!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class UserArray {
  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? description;
  String? email;
  String? uniqueId;
  String? countryCode;
  String? phoneNumber;
  String? addressLine1;
  String? addressLine2;
  String? historyDisclosure;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  String? profilePhoto;
  String? accountType;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? totalDistanceInKm;
  dynamic totalTimeInMin;
  dynamic avgSpeedInKmPerHour;
  int? followersCount;
  int? followingCount;
  bool? isFollowing;


  UserArray(
      {this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.description,
        this.email,
        this.uniqueId,
        this.countryCode,
        this.phoneNumber,
        this.addressLine1,
        this.addressLine2,
        this.city,
        this.state,
        this.country,
        this.zipCode,
        this.historyDisclosure,
        this.profilePhoto,
        this.accountType,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.totalDistanceInKm,
        this.totalTimeInMin,
        this.avgSpeedInKmPerHour,
        this.followersCount,
        this.followingCount,
        this.isFollowing
      });

  UserArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    description = json['description'];
    email = json['email'];
    uniqueId = json['uniqueId'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zipCode = json['zipCode'];
    historyDisclosure = json['historyDisclosure'];
    profilePhoto = json['profilePhoto'];
    accountType = json['accountType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    totalDistanceInKm = json['totalDistanceInKm'];
    totalTimeInMin = json['totalTimeInMin'];
    avgSpeedInKmPerHour = json['avgSpeedInKmPerHour'];
    followersCount = json['followersCount'];
    followingCount = json['followingCount'];
    isFollowing = json['isFollowing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
    data['description'] = this.description;
    data['email'] = this.email;
    data['uniqueId'] = this.uniqueId;
    data['countryCode'] = this.countryCode;
    data['phoneNumber'] = this.phoneNumber;
    data['addressLine1'] = this.addressLine1;
    data['addressLine2'] = this.addressLine2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['zipCode'] = this.zipCode;
    data['historyDisclosure'] = this.historyDisclosure;
    data['profilePhoto'] = this.profilePhoto;
    data['accountType'] = this.accountType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['totalDistanceInKm'] = this.totalDistanceInKm;
    data['totalTimeInMin'] = this.totalTimeInMin;
    data['avgSpeedInKmPerHour'] = this.avgSpeedInKmPerHour;
    data['followersCount'] = this.followersCount;
    data['followingCount'] = this.followingCount;
    data['isFollowing'] = this.isFollowing;
    return data;
  }
}

