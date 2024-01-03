import 'dart:io';

import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LibHelper implements LocalDB {
  Future<bool> containsKey(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  void setBool(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  void setInt(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  void setDouble(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  Future<bool?> getBool(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future<int?> getInt(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<double?> getDouble(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  void setString(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getString(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  void remove(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<SnackbarController> snackbar(title, description) async {
    return Get.snackbar(title, description,
        borderWidth: 1,
        backgroundColor: Color(0x46000000),
        colorText: Color(0xFFFFFFFF),
        margin: EdgeInsets.all(10),
        barBlur: 10,
        snackPosition: SnackPosition.BOTTOM);
  }

  Future<bool> isNetworkAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  String getPastTime(DateTime time) {
    var now = DateTime.now();
    var diffValue = now.difference(time);

    if (diffValue.inHours > 24) {
      return "${diffValue.inDays} day ago";
    } else {
      return "${diffValue.inHours} hours ago";
    }
  }

  String convertDateFormat(String dateTimeString, String newFormat) {
    DateFormat newDateFormat = DateFormat(newFormat);
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    String selectedDate = newDateFormat.format(dateTime);
    return selectedDate;
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }
}
