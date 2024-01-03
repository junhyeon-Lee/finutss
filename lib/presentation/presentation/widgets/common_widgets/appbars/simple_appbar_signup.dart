import 'package:finutss/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget simpleAppBarSignUp({String text = '', automaticallyImplyLeading = true, actions}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60.h),
    child: AppBar(
      elevation: text == 'Social' ? 8 : 0,
      backgroundColor: Colors.white,

      actions: actions,
      title: Text(text, style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: colorDarkGrey)),
      //  customText(
      //     overflow: TextOverflow.ellipsis,
      //     text: text,
      //     fontColor: Colors.black,
      //     fontSize: 24,
      //     fontWeight: FontWeight.bold),
      leadingWidth: 45.w,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: automaticallyImplyLeading == true
          ? Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: IconButton(
                  onPressed: () {
                    Get.back();
                    // Get.to(SignInScreen());
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 24.r,
                    color: Color(0xff303443),
                  )),
            )
          : null,
    ),
  );
}
