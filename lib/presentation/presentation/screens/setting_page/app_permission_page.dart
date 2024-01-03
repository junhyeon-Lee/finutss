import 'package:finutss/domain/controller/setting_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/switch_button_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppPermissionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundSilver,
      appBar: simpleAppBar(text: 'APP_PERMISSIONS'.tr) as PreferredSizeWidget?,
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.r),
            margin: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.white,
            ),
            child: GetBuilder<SettingController>(
                init: SettingController(),
                builder: (settingController) {
                  return Column(
                    children: [
                      for (var permission in settingController.appPermissionsList)
                        Padding(
                          padding: EdgeInsets.only(bottom: 14.0.h),
                          child: switchButtonCard(
                              title: permission['title'],
                              value: permission['value'],
                              onChangeFunction: (val) {
                                permission['value'] = val;
                                settingController.update();
                              }),
                        ),
                      /* -------------------------------------------------------------------------- */
                      /*                              bottom info text                              */
                      /* -------------------------------------------------------------------------- */
                      RichText(
                        text: TextSpan(
                            style: TextStyle(
                              height: 1.5,
                              color: Color(0XFF7F8391),
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '• For smooth use of the service, please allow us to receive app notifications from',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                              ),
                              TextSpan(
                                text: ' [Settings > Applications > Peanuts > Notifications] ',
                                style: TextStyle(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w500),
                              ),
                              TextSpan(
                                text: 'on your mobile device.',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                              )
                            ]),
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
