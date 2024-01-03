import 'package:finutss/presentation/screens/workout_screens/map_page.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';

class PrecautionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 16.0.w, right: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              size10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(
                      text: 'PRECAUTIONS'.tr, fontColor: Color(0xff303443), fontSize: 24, fontWeight: FontWeight.w700),
                  CircleAvatar(
                    backgroundColor: colorBackgroundSilver,
                    radius: 20.r,
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          CommunityMaterialIcons.window_close,
                          size: 24.r,
                          color: colorDarkGrey,
                        )),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      size20,
                      customText(
                          text: 'WORKOUT'.tr, fontColor: Color(0xff303443), fontSize: 20, fontWeight: FontWeight.bold),
                      size10,
                      Divider(
                        thickness: 2,
                        color: Color(0xffCDD5E9),
                      ),
                      size5,
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          style: TextStyle(
                            height: 2,
                            color: Color(0xff7F8391),
                            fontSize: 14.sp,
                          ),
                          children: [
                            TextSpan(
                              text: 'PRECAUTIONS_DETAIL_GUIDE'.tr,
                            ),
                          ],
                        ),
                      ),
                      size15,
                      customText(
                          text: 'COMMUNITY'.tr,
                          fontColor: Color(0xff303443),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      size10,
                      Divider(
                        thickness: 2,
                        color: Color(0xffCDD5E9),
                      ),
                      size5,
                      RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                              style: TextStyle(
                                height: 2,
                                color: Color(0xff7F8391),
                                fontSize: 14.sp,
                              ),
                              children: [
                                TextSpan(
                                  text: 'COMMUNITY_DETAILS_GUIDE'.tr,
                                ),
                              ])),
                      size15,
                      customText(
                          text: 'GUIDES_TO_USE_OUTDOOR_SERVICES'.tr,
                          fontColor: Color(0xff303443),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      size10,
                      Divider(
                        thickness: 2,
                        color: Color(0xffCDD5E9),
                      ),
                      size5,
                      RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                              style: TextStyle(
                                height: 2,
                                color: Color(0xff7F8391),
                                fontSize: 14.sp,
                              ),
                              children: [
                                TextSpan(
                                  text: 'GUIDES_TO_USE_OUTDOOR_SERVICES_DETAILS_GUIDE'.tr,
                                ),
                              ])),
                      size5,
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: customButton(
                        onTapFunction: () {
                          Get.off(() => MapPage());
                        },
                        height: 48,
                        radius: 15,
                        color: colorBlue,
                        text: "START_NOW".tr,
                        textColor: Colors.white,
                        textSize: 16),
                  ),
                ],
              ),
              size30,
            ],
          ),
        ),
      ),
    );
  }
}
