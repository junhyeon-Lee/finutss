import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Navigation {
  static void push(Widget child) {
    Get.to<dynamic>(child);
  }

  static void pushMaterial(context, Widget child) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => child));
  }

  static Future pushNamed(
    String routeName, {
    dynamic arg,
    Map<String, String>? params,
  }) async {
    return await Get.toNamed<dynamic>(routeName, arguments: arg, parameters: params);
  }

  static pushNamedMaterial(
    BuildContext context,
    String routeName, {
    dynamic arg,
  }) {
    Navigator.pushNamed(context, routeName, arguments: arg);
  }

  static void popAndPushNamed(
    String routeName, {
    dynamic arg,
    Map<String, String>? params,
  }) {
    Get.offAndToNamed<dynamic>(routeName, arguments: arg, parameters: params);
  }

  static void leftToRight(Widget child) {
    Get.to<dynamic>(() => child, transition: Transition.leftToRight);
  }

  static void rightToLeft(Widget child) {
    Get.to<dynamic>(() => child, transition: Transition.rightToLeft);
  }

  static Future<void> replace(String routeName, {dynamic arguments}) async {
    await Get.offNamed<dynamic>(routeName, arguments: arguments);
  }

  static void pop({Map<String, dynamic>? data}) {
    Get.back<dynamic>(result: data);
  }

  static void popMaterial(context) {
    Navigator.pop(
      context,
    );
  }

  static void doublePop() {
    Get
      ..back<dynamic>()
      ..back<dynamic>();
  }

  static void removeAll(Widget child) {
    Get.offAll<dynamic>(child);
  }

  static void popupUtil(String routeName) {
    Get.until((route) => Get.currentRoute == routeName);
  }

  static void replaceAll(
    String routeName, {
    dynamic arg,
    Map<String, String>? params,
  }) {
    Get.offAllNamed(routeName, arguments: arg, parameters: params);
  }


  static void openKeyword(){
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
  }


  static void closeKeyword(){
    FocusManager.instance.primaryFocus?.unfocus();
  }

}
