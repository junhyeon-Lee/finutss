import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

Widget fromToHeading({backgroundColor = Colors.white, String from = "Yeongdong-daero", String to = "Yeongdong-daero"}) {
  return Padding(
    padding: EdgeInsets.only(left: 14.w, right: 14.w),
    child: Container(
      height: 40.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: backgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          size5,
          Expanded(
            child: Row(
              children: [
                Icon(Icons.location_on_outlined, size: 20.r, color: Color(0xff3BCCE1)),
                size10,
                Expanded(
                  child: Text(
                    from,
                    style: TextStyle(color: Color(0xff303443), fontSize: 12.sp, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_outlined,
            color: Color(0xffF73A6B),
            size: 20.r,
          ),
          size10,
          Expanded(
            child: Text(
              to,
              style: TextStyle(color: Color(0xff303443), fontSize: 12.sp, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}
