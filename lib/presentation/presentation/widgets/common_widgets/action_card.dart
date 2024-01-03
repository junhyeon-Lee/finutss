import 'package:finutss/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'custom_text.dart';

Widget actionCard(
    {heading = '',
    activeValue,
    description,
    status,
    statusColor = const Color(0xff7F8391),
    icon = CommunityMaterialIcons.menu_right,
    isSuffixIconShow = true,
    onTapFunction}) {
  return InkWell(
    onTap: onTapFunction,
    child: Container(
      //height: 67.h,
      decoration: BoxDecoration(
          color: colorBackgroundSilver,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Color(0xffCDD5E9))),
      child: Padding(
        padding: description == null
            ? EdgeInsets.fromLTRB(18.w, 17.h, 19.w, 17.h)
            : EdgeInsets.fromLTRB(14.w, 12.h, 8.w, 12.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$heading',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (description != null || status != null) size10,
                  if (description != null || status != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                            text: description ?? '',
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontColor: Color(0xff7F8391)),
                        customText(
                            text: status ?? '',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontColor: statusColor),
                      ],
                    )
                ],
              ),
            ),
            if (activeValue != null)
              customText(
                  text: '$activeValue',
                  fontColor: Color(0xff7F8391),
                  fontSize: 12),
            size5,
            if (isSuffixIconShow)
              Icon(
                icon,
                size: 24.r,
              )
          ],
        ),
      ),
    ),
  );
}
