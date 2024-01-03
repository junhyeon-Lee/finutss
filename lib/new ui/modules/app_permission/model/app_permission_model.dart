import 'package:flutter/material.dart';

class AppPermissionModel{
  String iconPath;
  Color bgColor;
  String title,des;
  bool isOptional;

  AppPermissionModel(
      this.iconPath, this.bgColor, this.title, this.des, this.isOptional);
}