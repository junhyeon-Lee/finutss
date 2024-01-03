class VerificationModel {
  int? statusCode;
  String? message;
  Data? data;

  VerificationModel({this.statusCode, this.message, this.data});

  VerificationModel.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? lastName;
  String? username;
  String? description;
  String? email;
  String? uniqueId;
  dynamic countryCode;
  dynamic phoneNumber;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? country;
  int? zipCode;
  dynamic profilePhoto;
  String? accountType;
  dynamic mobileVerification;
  EmailVerification? emailVerification;
  dynamic resetPassword;
  dynamic bankAccountDetails;
  int? weightInKg;
  String? gender;
  int? yearOfBirth;
  int? age;
  int? heightInCm;
  int? bmi;
  dynamic basicMetabolism;
  dynamic recommendedExercise;
  dynamic defaultCurrency;
  String? defaultLanguage;
  String? loginType;
  String? loginRole;
  String? historyDisclosure;
  String? status;
  dynamic bannedAt;
  String? withdrawalReason;
  dynamic bannedBy;
  bool? isAgreement;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Data(
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
        this.profilePhoto,
        this.accountType,
        this.mobileVerification,
        this.emailVerification,
        this.resetPassword,
        this.bankAccountDetails,
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
        this.withdrawalReason,
        this.bannedBy,
        this.isAgreement,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
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
    profilePhoto = json['profilePhoto'];
    accountType = json['accountType'];
    mobileVerification = json['mobileVerification'];
    emailVerification = json['emailVerification'] != null
        ? new EmailVerification.fromJson(json['emailVerification'])
        : null;
    resetPassword = json['resetPassword'];
    bankAccountDetails = json['bankAccountDetails'];
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
    withdrawalReason = json['withdrawalReason'];
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
    data['mobileVerification'] = this.mobileVerification;
    if (this.emailVerification != null) {
      data['emailVerification'] = this.emailVerification!.toJson();
    }
    data['resetPassword'] = this.resetPassword;
    data['bankAccountDetails'] = this.bankAccountDetails;
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
    data['withdrawalReason'] = this.withdrawalReason;
    data['bannedBy'] = this.bannedBy;
    data['isAgreement'] = this.isAgreement;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
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