import 'package:finutss/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget simpleAppBar({String text = '', automaticallyImplyLeading = true, actions, ValueNotifier<double>? visible}) {
  ValueNotifier<double> newVal = ValueNotifier<double>(1.0);
  return PreferredSize(
    preferredSize: Size.fromHeight(60.h),
    child: ValueListenableBuilder(
      valueListenable: visible ?? newVal,
      builder: (BuildContext context, dynamic value, Widget? child) {
        return Align(
          heightFactor: value,
          alignment: Alignment(0, 0),
          child: Opacity(
            opacity: value,
            child: AppBar(
              elevation: 3.0,
              backgroundColor: Colors.white,
              actions: actions,
              title: Text(text, style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: colorDarkGrey)),
              leadingWidth: 45.w,
              automaticallyImplyLeading: automaticallyImplyLeading,
              leading: automaticallyImplyLeading == true
                  ? Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 24.r,
                            color: Color(0xff303443),
                          )),
                    )
                  : null,
            ),
          ),
        );
      },
      // child:
    ),
  );
}
