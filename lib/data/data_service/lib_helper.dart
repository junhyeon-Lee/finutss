import 'dart:io';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  static containsKey(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  static setBool(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static setInt(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  static setDouble(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  static getBool(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static getInt(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static getDouble(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  static setString(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static getString(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static remove(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static snackbar(title, description) async {
    ///TODO
    /*
    return Get.snackbar(title, description,
        borderWidth: 1,
        backgroundColor: Color(0x46000000),
        colorText: Color(0xFFFFFFFF),
        margin: EdgeInsets.all(10),
        barBlur: 10,
        snackPosition: SnackPosition.BOTTOM);
     */
  }

  static Future<bool> isNetworkAvailable() async {
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

  static DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  static String getPastTime(DateTime time) {
    var now = DateTime.now();
    var diffValue = now.difference(time);

    if (diffValue.inHours > 24) {
      return "${diffValue.inDays} day ago";
    } else {
      return "${diffValue.inHours} hours ago";
    }
  }

  static String convertDateFormat(String dateTimeString, String newFormat) {
    DateFormat newDateFormat = DateFormat(newFormat);
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    String selectedDate = newDateFormat.format(dateTime);
    return selectedDate;
  }

  static String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }
}
