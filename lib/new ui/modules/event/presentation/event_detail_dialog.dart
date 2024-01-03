
import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/app_string.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> eventDetailBottomSheet(BuildContext context,{String? title, String? content}) {
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 60.h,
            ),
            


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
                      title: title,
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    /*  Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  SizedBox(
                                    height: 18.h,
                                  ),


                                  Text(
                                    AppString.aeneanImperdietEtiam,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: AppColor.subTitleColor.withOpacity(0.9),
                                      height: 1.9,
                                      fontSize: 12.sp,
                                      letterSpacing: 0.1,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),

                                  SizedBox(
                                    height: 16.h,
                                  ),

                                  Text(
                                    AppString.maecenasNecOdioAnte,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: AppColor.subTitleColor.withOpacity(0.9),
                                      height: 1.9,
                                      fontSize: 12.sp,
                                      letterSpacing: 0.1,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),


                                  SizedBox(
                                    height: 71.h,
                                  ),

                                  
                                  Padding(padding: EdgeInsets.symmetric(horizontal: 22.w),
                                  child: CustomSliderButton(
                                    height: 42.3.h,
                                    title: 'JOIN_THE_EVENT'.tr, onTap: () {  }, isCancelButton: false,),
                                  ),


                                  SizedBox(
                                    height: 57.h,
                                  ),




                                ],
                              ),
                            ),*/
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
