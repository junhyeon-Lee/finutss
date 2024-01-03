import 'package:finutss/data/models/image.dart';
import 'package:finutss/data/models/user_Details_object.dart';

class GetUsersObject {
  GetUsersObject({
    this.users,
  });

  List<User>? users;

  factory GetUsersObject.fromMap(Map<String, dynamic> json) => GetUsersObject(
    users: json["users"] == null ? null : List<User>.from(json["users"].map((element) => User.fromMap(element))),
  );
}

class User {
  int userId;
  String? firstName;
  String? lastName;
  String username;
  String? status;
  String? biography;
  DateTime? birthDate;
  String? email;
  DateTime? emailVerifiedAt;
  int? phoneNumber;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  ///TODO ??????
  String? workoutType = null;
  ///TODO
  Image? image;
  UsersDetails? usersDetails;
  int? followersCount;
  int? followingCount;


  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.status,
    required this.biography,
    required this.birthDate,
    required this.email,
    required this.emailVerifiedAt,
    required this.phoneNumber,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    this.workoutType,
    required this.image,
    required this.usersDetails,
    this.followersCount,
    this.followingCount
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
    userId: json["user_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    username: json["username"],
    status: json["status"],
    biography: json["biography"],
    birthDate:  json["birthDate"] != null ? DateTime.parse(json["birthDate"]) : null,
    email: json["email"],
    emailVerifiedAt: json["emailVerifiedAt"],
    phoneNumber: json["phoneNumber"],
    role: json["role"] ,
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    image: json["image"] != null ? Image.fromMap(json["image"]) : null,
    usersDetails: json["updatedAt"] != null ? json["updatedAt"] : null,
  );
}

