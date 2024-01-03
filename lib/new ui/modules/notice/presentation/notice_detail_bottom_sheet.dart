import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/app_string.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> noticeDetailBottomSheet(BuildContext context, {String? title, String? content}) {
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    enableDrag: false,
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.black.withOpacity(0.2),
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        height: MediaQuery.of(context).size.height * 2,
        width: MediaQuery.of(context).size.width,
        child: SizedBox(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 55.h,
                bottom: 0,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 12.w),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            IconAssets.close,
                            scale: 4,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.elliptical(
                              MediaQuery.of(context).size.width,
                              100.0,
                            ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30.h,
                            ),
                            CustomSettingRow(
                              title: title ?? '',
                              fontsize: 18.sp,
                              horizontalPadding: 20.w,
                              fontWeight: FontWeight.w700,
                              showShareIcon: true,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 18.h,
                                      ),
                                      Html( data: content ?? '',),
                                      /*Text(
                                        content ?? '',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: AppColor.subTitleColor.withOpacity(0.9),
                                          fontSize: 11.6.sp,
                                          height: 1.65,
                                          letterSpacing: 0.1,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),*/

                                      /*   Text(
                                        AppString.noticeOfPartialChanges,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: AppColor.darkPink,
                                          height: 1.6,
                                          fontSize: 14.sp,
                                          letterSpacing: 0.1,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                      SizedBox(
                                        height: 16.h,
                                      ),

                                      Text(
                                        'Hello!',
                                        style: TextStyle(
                                          color: AppColor.subTitleColor.withOpacity(0.9),
                                          fontSize: 11.6.sp,
                                          height: 2.0,
                                          letterSpacing: 0.1,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),

                                      SizedBox(
                                        height: 4.h,
                                      ),


                                      Text(
                                        AppString.itsDailyExerciseHabit,
                                        style: TextStyle(
                                          color: AppColor.subTitleColor.withOpacity(0.9),
                                          fontSize: 11.6.sp,
                                          height: 1.65,
                                          letterSpacing: 0.1,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),

                                      SizedBox(
                                        height: 21.h,
                                      ),


                                      Text(
                                        AppString.checkTheChangeOfTerms,
                                        style: TextStyle(
                                          color: AppColor.greenSliderBg,
                                          fontSize: 12.sp,
                                          fontFamily: 'MontserratItalic',
                                          letterSpacing: 0.1,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),

                                      SizedBox(
                                        height: 17.h,
                                      ),

                                      Text(
                                        AppString.reflectedDate,
                                        style: TextStyle(
                                          color: AppColor.subTitleColor.withOpacity(0.9),
                                          fontSize: 11.6.sp,
                                          height: 1.8,
                                          letterSpacing: 0.1,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),

                                      SizedBox(
                                        height: 18.h,
                                      ),

                                      Text.rich(
                                        TextSpan(
                                          children: <InlineSpan>[
                                            TextSpan(
                                              text: "If you don't agree with the change, you can\nexpress your refusal through ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 11.5.sp,
                                                  height: 1.6,
                                                  letterSpacing: 0.1,
                                                  color: AppColor.subTitleColor.withOpacity(0.9)
                                              ),
                                            ),
                                            TextSpan(
                                              text: "'withdrawal from\nmembership'.",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 11.5.sp,
                                                  height: 1.6,
                                                  letterSpacing: 0.1,
                                                  color: AppColor.subTitleColor.withOpacity(0.9)
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),


                                      SizedBox(
                                        height: 16.h,
                                      ),



                                      Text.rich(
                                        TextSpan(
                                          children: <InlineSpan>[
                                            TextSpan(
                                              text: "If you have any questions, please make a ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 11.6.sp,
                                                  height: 1.65,
                                                  letterSpacing: 0.1,
                                                  color: AppColor.subTitleColor.withOpacity(0.9)
                                              ),
                                            ),
                                            TextSpan(
                                              text: "1:1 \ninquiry. ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 11.6.sp,
                                                  height: 1.65,
                                                  letterSpacing: 0.1,
                                                  color: AppColor.subTitleColor.withOpacity(0.9)
                                              ),
                                            ),
                                            TextSpan(
                                              text: "I will try to provide a pleasant service. \n\nThank you!",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 11.6.sp,
                                                  height: 1.65,
                                                  letterSpacing: 0.1,
                                                  color: AppColor.subTitleColor.withOpacity(0.9)
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),*/
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
