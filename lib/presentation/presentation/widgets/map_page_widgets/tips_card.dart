import 'package:finutss/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';

Widget tipsCard(tip) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    child: Padding(
      padding: EdgeInsets.all(8.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(CommunityMaterialIcons.lightbulb_on_outline, size: 24.r, color: Color(0xFF3BCCE1)),
          size10,
          Flexible(
            child: Text(
              "$tip",
              style: TextStyle(color: Color(0xff7F8391), fontSize: 14.sp, height: 1.5),
            ),
          )
        ],
      ),
    ),
  );
}
