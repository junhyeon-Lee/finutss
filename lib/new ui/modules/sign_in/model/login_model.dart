import 'package:get/get.dart';

class LoginModel {
  int? statusCode;
  String? message;
  String? error;
  Data? data;

  LoginModel({this.statusCode, this.message, this.data,this.error});

  LoginModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}



class Data {
  RxString? workoutType = ''.obs;
  String? token;
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
  String? city;
  String? state;
  String? country;
  String? zipCode;
  String? profilePhoto;
  String? accountType;
  EmailVerification? emailVerification;
  int? weightInKg;
  String? gender;
  int? yearOfBirth;
  int? age;
  int? heightInCm;
  int? bmi;
  dynamic basicMetabolism;
  dynamic recommendedExercise;
  String? defaultCurrency;
  String? defaultLanguage;
  String? loginType;
  String? loginRole;
  String? historyDisclosure;
  String? status;
  String? bannedAt;
  String? bannedBy;
  bool? isAgreement;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? channelId;
  int? followersCount;
  int? followingCount;
  dynamic totalDistanceInKm;
  dynamic totalTimeInMin;
  dynamic avgSpeedInKmPerHour;
  dynamic totalRideDistanceInKm;
  dynamic totalRideTimeInMin;
  dynamic avgRideSpeedInKmPerHour;
  dynamic totalRunDistanceInKm;
  dynamic totalRunTimeInMin;
  dynamic avgRunSpeedInKmPerHour;
  String? lastRecordUpdatedAt;

  Data(
      {
        this.workoutType,
        this.token,
        this.id,
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
        this.emailVerification,
        this.profilePhoto,
        this.accountType,
        this.weightInKg,
        this.gender,
        this.yearOfBirth,
        this.age,
        this.heightInCm,
        this.bmi,
        this.basicMetabolism,
        this.recommendedExercise,
        this.defaultCurrency,
        this.defaultLanguage,
        this.loginType,
        this.loginRole,
        this.historyDisclosure,
        this.status,
        this.bannedAt,
        this.bannedBy,
        this.isAgreement,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.channelId,
        this.followersCount,
        this.followingCount,
        this.totalDistanceInKm,
        this.totalTimeInMin,
        this.avgSpeedInKmPerHour,
        this.totalRideDistanceInKm,
        this.totalRideTimeInMin,
        this.avgRideSpeedInKmPerHour,
        this.totalRunDistanceInKm,
        this.totalRunTimeInMin,
        this.avgRunSpeedInKmPerHour,
        this.lastRecordUpdatedAt,
      });

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
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
    emailVerification = json['emailVerification'] != null
        ? new EmailVerification.fromJson(json['emailVerification'])
        : null;
    profilePhoto = json['profilePhoto'];
    accountType = json['accountType'];
    weightInKg = json['weightInKg'];
    gender = json['gender'];
    yearOfBirth = json['yearOfBirth'];
    age = json['age'];
    heightInCm = json['heightInCm'];
    bmi = json['bmi'];
    basicMetabolism = json['basicMetabolism'];
    recommendedExercise = json['recommendedExercise'];
    defaultCurrency = json['defaultCurrency'];
    defaultLanguage = json['defaultLanguage'];
    loginType = json['loginType'];
    loginRole = json['loginRole'];
    historyDisclosure = json['historyDisclosure'];
    status = json['status'];
    bannedAt = json['bannedAt'];
    bannedBy = json['bannedBy'];
    isAgreement = json['isAgreement'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    channelId = json['channelId'];
    followersCount = json['followersCount'];
    followingCount = json['followingCount'];
    totalDistanceInKm = json['totalDistanceInKm'];
    totalTimeInMin = json['totalTimeInMin'];
    avgSpeedInKmPerHour = json['avgSpeedInKmPerHour'];
    totalRideDistanceInKm = json['totalRideDistanceInKm'];
    totalRideTimeInMin = json['totalRideTimeInMin'];
    avgRideSpeedInKmPerHour = json['avgRideSpeedInKmPerHour'];
    totalRunDistanceInKm = json['totalRunDistanceInKm'];
    totalRunTimeInMin = json['totalRunTimeInMin'];
    avgRunSpeedInKmPerHour = json['avgRunSpeedInKmPerHour'];
    lastRecordUpdatedAt = json['lastRecordUpdatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
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
    if (this.emailVerification != null) {
      data['emailVerification'] = this.emailVerification!.toJson();
    }
    data['profilePhoto'] = this.profilePhoto;
    data['accountType'] = this.accountType;
    data['weightInKg'] = this.weightInKg;
    data['gender'] = this.gender;
    data['yearOfBirth'] = this.yearOfBirth;
    data['age'] = this.age;
    data['heightInCm'] = this.heightInCm;
    data['bmi'] = this.bmi;
    data['basicMetabolism'] = this.basicMetabolism;
    data['recommendedExercise'] = this.recommendedExercise;
    data['defaultCurrency'] = this.defaultCurrency;
    data['defaultLanguage'] = this.defaultLanguage;
    data['loginType'] = this.loginType;
    data['loginRole'] = this.loginRole;
    data['historyDisclosure'] = this.historyDisclosure;
    data['status'] = this.status;
    data['bannedAt'] = this.bannedAt;
    data['bannedBy'] = this.bannedBy;
    data['isAgreement'] = this.isAgreement;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['channelId'] = this.channelId;
    data['followersCount'] = this.followersCount;
    data['followingCount'] = this.followingCount;
    data['totalDistanceInKm'] = this.totalDistanceInKm;
    data['totalTimeInMin'] = this.totalTimeInMin;
    data['avgSpeedInKmPerHour'] = this.avgSpeedInKmPerHour;
    data['totalRideDistanceInKm'] = this.totalRideDistanceInKm;
    data['totalRideTimeInMin'] = this.totalRideTimeInMin;
    data['avgRideSpeedInKmPerHour'] = this.avgRideSpeedInKmPerHour;
    data['totalRunDistanceInKm'] = this.totalRunDistanceInKm;
    data['totalRunTimeInMin'] = this.totalRunTimeInMin;
    data['avgRunSpeedInKmPerHour'] = this.avgRunSpeedInKmPerHour;
    data['lastRecordUpdatedAt'] = this.lastRecordUpdatedAt;
    return data;
  }
}

class MobileVerification {
  int? otp;
  bool? isVerified;
  String? initiatedAt;

  MobileVerification({this.otp, this.isVerified, this.initiatedAt});

  MobileVerification.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    isVerified = json['isVerified'];
    initiatedAt = json['initiatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['isVerified'] = this.isVerified;
    data['initiatedAt'] = this.initiatedAt;
    return data;
  }
}



class EmailVerification {
  bool? isVerified;
  String? initiatedAt;

  EmailVerification({this.isVerified, this.initiatedAt});

  EmailVerification.fromJson(Map<String, dynamic> json) {
    isVerified = json['isVerified'];
    initiatedAt = json['initiatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isVerified'] = this.isVerified;
    data['initiatedAt'] = this.initiatedAt;
    return data;
  }
}



/*
class Data {
  String? token;
  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? uniqueId;
  String? countryCode;
  String? phoneNumber;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  String? profilePhoto;
  String? accountType;
  int? weight;
  String? gender;
  int? yearOfBirth;
  int? age;
  int? height;
  int? bmi;
  int? basicMetabolism;
  int? recommendedExercise;
  String? loginType;
  String? loginRole;
  String? historyDisclosure;
  String? status;
  Null? bannedAt;
  Null? bannedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? channelId;
  int? followersCount;
  int? followingCount;
  int? totalDistanceInKm;
  int? totalTimeInMin;
  int? avgSpeedInKmPerHour;
  String? lastRecordUpdatedAt;

  Data(
      {this.token,
        this.id,
        this.firstName,
        this.lastName,
        this.username,
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
        this.profilePhoto,
        this.accountType,
        this.weight,
        this.gender,
        this.yearOfBirth,
        this.age,
        this.height,
        this.bmi,
        this.basicMetabolism,
        this.recommendedExercise,
        this.loginType,
        this.loginRole,
        this.historyDisclosure,
        this.status,
        this.bannedAt,
        this.bannedBy,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.channelId,
        this.followersCount,
        this.followingCount,
        this.totalDistanceInKm,
        this.totalTimeInMin,
        this.avgSpeedInKmPerHour,
        this.lastRecordUpdatedAt,
      });

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
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
    profilePhoto = json['profilePhoto'];
    accountType = json['accountType'];
    weight = json['weightInKg'];
    gender = json['gender'];
    yearOfBirth = json['yearOfBirth'];
    age = json['age'];
    height = json['heightInCm'];
    bmi = json['bmi'];
    basicMetabolism = json['basicMetabolism'];
    recommendedExercise = json['recommendedExercise'];
    loginType = json['loginType'];
    loginRole = json['loginRole'];
    historyDisclosure = json['historyDisclosure'];
    status = json['status'];
    bannedAt = json['bannedAt'];
    bannedBy = json['bannedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    channelId = json['channelId'];
   */
/* followersCount = json['followersCount'];
    followingCount = json['followingCount'];
    totalDistanceInKm = json['totalDistanceInKm'];
    totalTimeInMin = json['totalTimeInMin'];
    avgSpeedInKmPerHour = json['avgSpeedInKmPerHour'];
    lastRecordUpdatedAt = json['lastRecordUpdatedAt'];*//*

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
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
    data['profilePhoto'] = this.profilePhoto;
    data['accountType'] = this.accountType;
    data['weightInKg'] = this.weight;
    data['gender'] = this.gender;
    data['yearOfBirth'] = this.yearOfBirth;
    data['age'] = this.age;
    data['heightInCm'] = this.height;
    data['bmi'] = this.bmi;
    data['basicMetabolism'] = this.basicMetabolism;
    data['recommendedExercise'] = this.recommendedExercise;
    data['loginType'] = this.loginType;
    data['loginRole'] = this.loginRole;
    data['historyDisclosure'] = this.historyDisclosure;
    data['status'] = this.status;
    data['bannedAt'] = this.bannedAt;
    data['bannedBy'] = this.bannedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['channelId'] = this.channelId;
*/
/*    data['followersCount'] = this.followersCount;
    data['followingCount'] = this.followingCount;
    data['totalDistanceInKm'] = this.totalDistanceInKm;
    data['totalTimeInMin'] = this.totalTimeInMin;
    data['avgSpeedInKmPerHour'] = this.avgSpeedInKmPerHour;
    data['lastRecordUpdatedAt'] = this.lastRecordUpdatedAt;*//*

    return data;
  }
}*/
