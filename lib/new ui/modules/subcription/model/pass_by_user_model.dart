import 'dart:convert';
import 'package:flutter/material.dart';

UserPassByModel UserPassByModelFromJson(String str) =>
    UserPassByModel.fromJson(json.decode(str));

String UserPassByModelToJson(UserPassByModel data) =>
    json.encode(data.toJson());

class UserPassByModel {
  UserPassByModel({
    this.name,
    this.subTitle,
    this.image,
    this.date,
    this.color,
  });

  String? name;
  String? subTitle;
  String? image;
  String? date;
  Color? color;

  factory UserPassByModel.fromJson(Map<String, dynamic> json) =>
      UserPassByModel(
        name: json["name"],
        subTitle: json["subTitle"],
        image: json["Image"],
        date: json["date"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "subTitle": subTitle,
        "Image": image,
        "date": date,
        "color": color,
      };
}
