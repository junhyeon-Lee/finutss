import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ShowMessagesView extends StatefulWidget {
  const ShowMessagesView({required this.id, required this.fromId, required this.dateVisibility, Key? key})
      : super(key: key);

  final String id;
  final String fromId;
  final bool dateVisibility;

  @override
  State<ShowMessagesView> createState() => _ShowMessagesViewState();
}

class _ShowMessagesViewState extends State<ShowMessagesView> {
  int firstTime = 0;

  int set = 0;

  RxBool selectedIndex = false.obs;

  @override
  Widget build(BuildContext context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;
    var date = DateFormat('dd-MM-yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(int.parse(DateTime.now().millisecondsSinceEpoch.toString())))
        .toLowerCase();
    var times = DateFormat('hh:mm a')
        .format(DateTime.fromMillisecondsSinceEpoch(int.parse(DateTime.now().millisecondsSinceEpoch.toString())))
        .toLowerCase();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // widget.dateVisibility
        //     ? Align(
        //         alignment: Alignment.center,
        //         child: Text(date, style: TextStyle()),
        //       )
        //     : const SizedBox(),
        _showMessage(date, times, context, px)
      ],
    );
  }

  _showMessage(var date, var times, BuildContext context, var px) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      child: widget.fromId == widget.id
          ? _rightSideMessages(date, times, context, px)
          : _leftSideMessages(times, context, px),
    );
  }

  _rightSideMessages(var date, String times, BuildContext context, double px) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                  width: Get.width,
                  margin: EdgeInsets.only(left: 32.w),
                  decoration: BoxDecoration(
                    color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.1),
                    // border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                  ),
                  child: Text(
                    "Hey, How are you? ",
                    style: TextStyle(
                        color: AppColor.blueTextColor.withOpacity(0.9), fontWeight: FontWeight.w400, fontSize: 14.sp),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    times,
                    style: TextStyle(
                      fontSize: 10.sp,
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.w400,
                      color: AppColor.blueTextColor[100]!.withOpacity(0.4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          CachedNetworkImage(
              imageUrl: ImageAssets.women,
              imageBuilder: (context, imageProvider) => Container(
                    height: 38.r,
                    width: 38.r,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        border: Border.all(
                            color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), width: 1.5),
                        image: DecorationImage(
                            image: AssetImage(
                              ImageAssets.women,
                            ),
                            fit: BoxFit.cover)),
                  ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Container(
                    height: 38.r,
                    width: 38.r,
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
                  )),
        ],
      ),
    );
  }

  _leftSideMessages(String times, BuildContext context, double px) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CachedNetworkImage(
              imageUrl: ImageAssets.women,
              imageBuilder: (context, imageProvider) => Container(
                    height: 38.r,
                    width: 38.r,
                margin: EdgeInsets.only(right: 32.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        border: Border.all(
                            color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), width: 1.5),
                        image: DecorationImage(
                            image: AssetImage(
                              ImageAssets.women,
                            ),
                            fit: BoxFit.cover)),
                  ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Container(
                    height: 38.r,
                    width: 38.r,
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
                  )),
          SizedBox(
            width: 8.w,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Chi Chan",
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      times,
                      style: TextStyle(
                        fontSize: 10.sp,
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.w400,
                        color: AppColor.blueTextColor[100]!.withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.6),
                    // border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                  ),
                  child: Text(
                    "Hey, How are you? ",
                    style: TextStyle(
                        color: AppColor.blueTextColor.withOpacity(0.9), fontWeight: FontWeight.w400, fontSize: 14.sp),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
