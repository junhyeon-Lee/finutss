import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

Widget permissionsCard(
    {onTapFunction,
    context,
    icon,
    double height = 68,
    iconColor = colorWhitish,
    String title = '',
    String text = '',
    bool isOptional = true}) {
  return Column(
    children: [
      InkWell(
        onTap: onTapFunction,
        child: Container(
          height: height.h,
          //height: getScreenHeight(100),
          //height: 72,
          decoration: BoxDecoration(color: colorBackgroundSilver, borderRadius: BorderRadius.circular(12.r)),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10.w, 13.h, 15.w, 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Color(0xffffffff),
                  child: Icon(
                    icon,
                    size: 21.r,
                    color: iconColor,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  customText(
                                      text: title,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 16,
                                      fontColor: colorDarkGrey,
                                      fontWeight: FontWeight.bold),
                                  isOptional
                                      ? customText(
                                          text: 'OPTIONAL'.tr,
                                          fontSize: 12,
                                          overflow: TextOverflow.ellipsis,
                                          fontColor: colorWhitish,
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        size5,
                        Expanded(
                          child: customText(
                            text: text,
                            height: 1.5,
                            fontSize: 12,
                            fontColor: colorWhitish,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 14.h),
    ],
  );
}
