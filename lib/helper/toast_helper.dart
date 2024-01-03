import 'package:another_flushbar/flushbar.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppToast {
  static void showSnackBar({required String title, required message}) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      messageText: Text(
        message,
        style: TextStyle(color: AppColor.red),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: AppColor.backGroundColor,
    ).show(Get.context!);
  }

  static void showGreenSnackBar({required message,Color? bgColor,Color? textColor}) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      messageText: Text(
        message,
        style: TextStyle(color: textColor ?? AppColor.whiteColor),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: bgColor ?? AppColor.blue,
    ).show(Get.context!);
  }

  static void bluetoothSnackBar({required message,Color? bgColor,Color? textColor}) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      messageText: Text(
        message,
        style: TextStyle(color: textColor ?? AppColor.whiteColor,height: 1.5,fontWeight: FontWeight.w500,fontSize: 13.sp),
      ),
      duration: const Duration(seconds: 5),
      backgroundColor: bgColor ?? AppColor.blue,
    ).show(Get.context!);
  }

  static void toastMessage(String message) {
    /*Fluttertoast.showToast(
        msg: message,
        textColor: AppColor.whiteColor,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: AppColor.black,
        fontSize: 12.sp);*/
  }
}