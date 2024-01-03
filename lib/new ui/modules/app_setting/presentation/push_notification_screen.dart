import 'package:finutss/new%20ui/modules/app_setting/controller/push_notifications_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PushNotificationScreen extends StatelessWidget {
  final PushNotificationsController controller =
      Get.put(PushNotificationsController());

  PushNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomSettingRow(
              title: "PUSH_NOTIFICATIONS".tr.toUpperCase(),
              fontsize: 18.sp,
              horizontalPadding: 18.w,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.NotificationModel1.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 7.h,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColor.whiteColor,
                                  borderRadius: BorderRadius.circular(
                                    6,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.cardGradiant1
                                          .withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 15,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 5.h,
                                  horizontal: 10.w,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10.w,
                                    ),

                                    Text(
                                      controller.NotificationModel1[index].title.toString().tr,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.blueTextColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Transform.scale(
                                      scale: 0.9,
                                      child: Obx(()=>Switch(
                                        onChanged: (bool value) {
                                          if(controller.NotificationModel1[index].title== 'DO_NOT_DISTURB'){
                                            for(int i=0; i<controller.NotificationModel1.length; i++){
                                              controller
                                                  .NotificationModel1[i].isEnable.value=false;
                                            }
                                            controller
                                                .NotificationModel1[index].isEnable.value =true;
                                          }else if(controller.NotificationModel1[index].title== 'ALL'){
                                            if(controller.NotificationModel1[0].isEnable.value) {
                                              controller.NotificationModel1[0].isEnable.value = false;
                                              controller.NotificationModel1[1].isEnable.value = false;
                                              controller.NotificationModel1[2].isEnable.value = false;
                                              controller.NotificationModel1[3].isEnable.value = false;
                                              controller.NotificationModel1[4].isEnable.value = true;
                                            }else{
                                              controller.NotificationModel1[0].isEnable.value = true;
                                              controller.NotificationModel1[1].isEnable.value = true;
                                              controller.NotificationModel1[2].isEnable.value = true;
                                              controller.NotificationModel1[3].isEnable.value = true;
                                              controller.NotificationModel1[4].isEnable.value = false;
                                            }
                                          }else {
                                            controller
                                                .NotificationModel1[index].isEnable.value =
                                            !controller
                                                .NotificationModel1[index].isEnable.value;

                                            if(controller
                                                .NotificationModel1[1].isEnable.value && controller
                                                .NotificationModel1[2].isEnable.value &&
                                                controller.NotificationModel1[3].isEnable.value){
                                              controller
                                                  .NotificationModel1[0].isEnable.value =true;
                                            }else{
                                              controller
                                                  .NotificationModel1[0].isEnable.value =false;
                                            }

                                            controller.NotificationModel1[4].isEnable.value =false;

                                            if(!controller
                                                .NotificationModel1[1].isEnable.value && !controller
                                                .NotificationModel1[2].isEnable.value &&
                                                !controller.NotificationModel1[3].isEnable.value){
                                              controller
                                                  .NotificationModel1[4].isEnable.value =true;
                                            }
                                          }
                                        },
                                        value: controller.NotificationModel1[index].isEnable.value,
                                        activeColor: AppColor.orangeColor,
                                        activeTrackColor: AppColor.orangeColor
                                            .withOpacity(0.2),
                                        inactiveThumbColor:
                                        AppColor.inActiveSwitch,
                                        inactiveTrackColor:
                                        AppColor.inActiveSwitch,
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(
                        height: 12.h,
                      ),
                      Text(
                        "PUSH_NOTIFICATIONS_INFO".tr,
                        style: TextStyle(
                          color: AppColor.blueTextColor.withOpacity(0.7),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
