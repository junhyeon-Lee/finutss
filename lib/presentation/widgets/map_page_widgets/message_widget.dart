import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/user_circle_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

Widget messageWidget({String message = 'Are you there?', userInfo}) {
  return Padding(
    padding: EdgeInsets.only(left: 16.0.w, bottom: 16.h),
    child: Container(
        child: Row(
      children: [
        userAvatar(width: 50, height: 50, userInfo: userInfo),
        size10,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0.w),
              child: Text(
                userInfo['nickName'],
                style: TextStyle(color: Color(0xff000000), fontWeight: FontWeight.w600, fontSize: 14.sp),
              ),
            ),
            SizedBox(
              width: 250.w,
              child: Card(
                color: Colors.white.withOpacity(0.7),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27.r)),
                child: Container(
                  // width: Get.width * 0.5,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.w, top: 6.h, bottom: 6.h, right: 15.w),
                    child: Text(
                      message,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xFF515358),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    )),
  );
}
