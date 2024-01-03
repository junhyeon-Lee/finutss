import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
  static void showErrorSnackBar(
      {required String message, required String title}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      borderRadius: 8,
      backgroundColor: Colors.black45,
      animationDuration: const Duration(milliseconds: 500),
      barBlur: 10,
      colorText: AppColor.whiteColor,
      isDismissible: false,
    );
  }
}
