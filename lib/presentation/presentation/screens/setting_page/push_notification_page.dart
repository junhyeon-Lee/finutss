import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/setting_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/switch_button_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PushNotificationPage extends StatelessWidget {
  final _authController = Get.put(AuthController());
  final _settingController = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    ///TODO _authController.user["alertSystem"]; uthController.user["alertWorkout"]; uthController.user["alertWorkout"]; _authController.user["alertInvite"]; _authController.user["alertDoNotDisturb"];
    /*
    if (_authController.user != null) {
      _settingController.pushNotificationList[1]["value"] = _authController.user["alertSystem"];
      _settingController.pushNotificationList[2]["value"] = _authController.user["alertWorkout"];
      _settingController.pushNotificationList[3]["value"] = _authController.user["alertWorkout"];
      _settingController.pushNotificationList[4]["value"] = _authController.user["alertInvite"];
      _settingController.pushNotificationList[5]["value"] = _authController.user["alertDoNotDisturb"];
    }

     */

    return Scaffold(
      backgroundColor: colorBackgroundSilver,
      appBar: simpleAppBar(text: 'PUSH_NOTIFICATIONS'.tr) as PreferredSizeWidget?,
      body: GetBuilder<AuthController>(builder: (authController) {
        return Container(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.r),
              margin: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Colors.white,
              ),
              child: GetBuilder<SettingController>(builder: (settingController) {
                return Column(
                  children: [
                    for (var permission in settingController.pushNotificationList)
                      Padding(
                        padding: EdgeInsets.only(bottom: 14.0.h),
                        child: switchButtonCard(
                            title: permission['title'],
                            value: permission['value'],
                            onChangeFunction: (bool val) {
                              String mySelectedName = permission["name"];

                              var myItem = settingController.pushNotificationList
                                  .indexWhere((element) => element['name'] == mySelectedName);

                              if (myItem >= 0) {
                                settingController.pushNotificationList[myItem]['value'] = val;
                              }

                              int allSelectedLength = settingController.pushNotificationList
                                  .where((element) => element['value'] == true)
                                  .toList()
                                  .length;

                              for (int i = 0; i < settingController.pushNotificationList.length; i++) {
                                String itemName = settingController.pushNotificationList[i]['name'];
                                if (mySelectedName == 'all') {
                                  if (itemName == 'alertDoNotDisturb') {
                                    settingController.pushNotificationList[i]['value'] = !val;
                                  } else {
                                    settingController.pushNotificationList[i]['value'] = val;
                                  }
                                } else if (mySelectedName == 'alertDoNotDisturb') {
                                  if (itemName == 'alertDoNotDisturb') {
                                    settingController.pushNotificationList[i]['value'] = val;
                                  } else {
                                    settingController.pushNotificationList[i]['value'] = !val;
                                  }
                                } else {
                                  if (allSelectedLength >= 1) {
                                    if (allSelectedLength == 2) {
                                      if (itemName == 'alertDoNotDisturb') {
                                        settingController.pushNotificationList[i]['value'] = false;
                                      }
                                    }
                                    if (allSelectedLength == 4) {
                                      if (itemName == 'all') {
                                        settingController.pushNotificationList[i]['value'] = val;
                                      }
                                    }
                                  } else {
                                    if (itemName == 'alertDoNotDisturb') {
                                      settingController.pushNotificationList[i]['value'] = !val;
                                    }
                                  }
                                }
                              }
                              authController.callApiUpdateUserInfo({
                                "alertSystem": settingController.pushNotificationList[1]['value'],
                                "alertWorkout": settingController.pushNotificationList[2]['value'],
                                "alertFollowing": settingController.pushNotificationList[3]['value'],
                                "alertInvite": settingController.pushNotificationList[4]['value'],
                                "alertDoNotDisturb": settingController.pushNotificationList[5]['value'],
                              });
                              settingController.update();
                            }),
                      ),
                    /* -------------------------------------------------------------------------- */
                    /*                              bottom info text                              */
                    /* -------------------------------------------------------------------------- */
                    Row(
                      children: [
                        Expanded(
                          child: customText(
                              text: 'KST_2300_0800_NOT_NOTIFIED'.tr, fontSize: 14, overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    size20,
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                            height: 1.5,
                            color: Color(0XFF7F8391),
                          ),
                          children: [
                            TextSpan(
                              text: 'PUSH_NOTIFICATIONS_INFO'.tr,
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                          ]),
                    )
                  ],
                );
              }),
            ),
          ),
        );
      }),
    );
  }
}
