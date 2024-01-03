class RecommendedModel {
  int? statusCode;
  String? message;
  Data? data;

  RecommendedModel({this.statusCode, this.message, this.data});

  RecommendedModel.fromJson(Map<String, dynamic> json) {
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
  List<RecommendedUsersArray>? recommendedUsersArray;
  List<HotUsersArray>? hotUsersArray;

  Data({this.recommendedUsersArray, this.hotUsersArray});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['recommendedUsersArray'] != null) {
      recommendedUsersArray = <RecommendedUsersArray>[];
      json['recommendedUsersArray'].forEach((v) {
        recommendedUsersArray!.add(new RecommendedUsersArray.fromJson(v));
      });
    }
    if (json['hotUsersArray'] != null) {
      hotUsersArray = <HotUsersArray>[];
      json['hotUsersArray'].forEach((v) {
        hotUsersArray!.add(new HotUsersArray.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recommendedUsersArray != null) {
      data['recommendedUsersArray'] =
          this.recommendedUsersArray!.map((v) => v.toJson()).toList();
    }
    if (this.hotUsersArray != null) {
      data['hotUsersArray'] =
          this.hotUsersArray!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecommendedUsersArray {
  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? description;
  String? email;
  String? profilePhoto;
  String? accountType;
  int? weightInKg;
  String? gender;
  int? yearOfBirth;
  int? age;
  int? heightInCm;
  int? bmi;
  int? basicMetabolism;
  int? recommendedExercise;
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
  bool? isFollowing;
  bool? isShowFollowYou;

  RecommendedUsersArray({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.description,
    this.email,
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
    this.isFollowing,
    this.isShowFollowYou
  });

  RecommendedUsersArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    description = json['description'];
    email = json['email'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
    data['description'] = this.description;
    data['email'] = this.email;
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
    return data;
  }
}

class EmailVerification {
  int? otp;
  bool? isVerified;
  String? initiatedAt;

  EmailVerification({this.otp, this.isVerified, this.initiatedAt});

  EmailVerification.fromJson(Map<String, dynamic> json) {
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

class HotUsersArray {
  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? description;
  String? email;
  String? password;
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
  int? weightInKg;
  String? gender;
  int? yearOfBirth;
  int? age;
  int? heightInCm;
  int? bmi;
  int? basicMetabolism;
  int? recommendedExercise;
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
  bool? isFollowing;

  HotUsersArray(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.description,
      this.email,
      this.password,
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
      this.isFollowing});

  HotUsersArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    description = json['description'];
    email = json['email'];
    password = json['password'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
    data['description'] = this.description;
    data['email'] = this.email;
    data['password'] = this.password;
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
    return data;
  }
}

class MobileVerification {
  int? otp;
  bool? isVerified;
  String? verifiedAt;
  String? initiatedAt;

  MobileVerification(
      {this.otp, this.isVerified, this.verifiedAt, this.initiatedAt});

  MobileVerification.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    isVerified = json['isVerified'];
    verifiedAt = json['verifiedAt'];
    initiatedAt = json['initiatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['isVerified'] = this.isVerified;
    data['verifiedAt'] = this.verifiedAt;
    data['initiatedAt'] = this.initiatedAt;
    return data;
  }
}
