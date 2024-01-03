import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageView extends StatelessWidget {
  final bool? isOnline;

  MessageView({Key? key, this.isOnline = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0.w, bottom: 16.h),
      child: Container(
          child: Row(
        children: [
          CachedNetworkImage(
              imageUrl: ImageAssets.women,
              imageBuilder: (context, imageProvider) => Container(
                    height: 50.r,
                    width: 50.r,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        border: Border.all(
                            color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), width: 1.5),
                        image: DecorationImage(
                            image: AssetImage(
                              ImageAssets.women,
                            ),
                            fit: BoxFit.cover)),
                    child: Stack(
                      children: [
                        if (isOnline ?? false)
                          Positioned(
                            right: 0,
                            top: 5.h,
                            child: Container(
                              height: 7.h,
                              width: 7.h,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Container(
                    height: 50.r,
                    width: 50.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      border: Border.all(
                          color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), width: 1.5),
                      image: DecorationImage(
                          image: AssetImage(
                            ImageAssets.women,
                          ),
                          fit: BoxFit.cover),
                    ),
                    child: Stack(
                      children: [
                        if (isOnline ?? false)
                          Positioned(
                            right: 0,
                            top: 5.h,
                            child: Container(
                              height: 7.h,
                              width: 7.h,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                            ),
                          )
                      ],
                    ),
                  )),
          // userAvatar(width: 50, height: 50, userInfo: userInfo),
          SizedBox(
            height: 10.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.0.w),
                child: Text(
                  'Sophia',
                  style: TextStyle(color: Color(0xff011C42), fontWeight: FontWeight.w500, fontSize: 14.sp),
                ),
              ),
              SizedBox(
                width: 210.w,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27.r)),
                  child: Container(
                    // width: Get.width * 0.5,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.w, top: 6.h, bottom: 6.h, right: 15.w),
                      child: Text(
                        'Hey, Lilly. Are you there?',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xFF7F8391),
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
}
