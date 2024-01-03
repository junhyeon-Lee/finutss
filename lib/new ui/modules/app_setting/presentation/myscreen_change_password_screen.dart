import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/controller/myscreen_pass_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/widget/custom_login_button.dart';
import 'package:finutss/new%20ui/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class MyScreenChangePasswordScreen extends StatelessWidget {
  final MyScreenPassController controller = Get.put(MyScreenPassController());
  final AppSettingController settingController = Get.find();

  MyScreenChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            CustomSettingRow(
              horizontalPadding: 20.w,
              title: 'CURRENT_PASSWORD'.tr,
              fontsize: 18.sp,
            ),
            Expanded(
              child: LayoutBuilder(builder: (context, constraint) {
                return SingleChildScrollView(
                    child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraint.maxHeight),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 18.w,
                                  vertical: 10.h,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Text(
                                      'PLEASE_INCLUDE_614_CHARACTERS_ENGLISHNUMBERSPECIAL_CHARACTERS'
                                          .tr,
                                      maxLines: 3,
                                      style: TextStyle(
                                        color: AppColor.subTitleColor
                                            .withOpacity(
                                          0.5,
                                        ),
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.2,
                                        fontSize: 13.sp,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                    Obx(
                                      () => CustomTextField(
                                        obscureText: controller.show.value,
                                        title: 'CURRENT_PASSWORD'.tr,
                                        fillColor: AppColor.whiteColor,
                                        showBottomErrorMsg: settingController.showBottomErrorMsg.value,
                                        controller:
                                            controller.currentPassController,
                                        errorMsg: controller.passErrorMsg.value,
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.only(
                                            right: 15.w,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.show.value =
                                                  !controller.show.value;
                                            },
                                            child: Icon(
                                              controller.show.value
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                    Obx(
                                      () => CustomTextField(
                                        obscureText: controller.show1.value,
                                        title: 'PLEASE_ENTER_A_NEW_PASSWORD'.tr,
                                        fillColor: AppColor.whiteColor,
                                        showBottomErrorMsg: settingController.showBottomErrorMsg.value,
                                        controller:
                                            controller.newPassController,
                                        errorMsg: controller.passErrorMsg.value,
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.only(
                                            right: 15.w,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.show1.value =
                                                  !controller.show1.value;
                                            },
                                            child: Icon(
                                              controller.show1.value
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                    Obx(
                                      () => CustomTextField(
                                        obscureText: controller.show2.value,
                                        title: 'CONFIRM_PASSWORD'.tr,
                                        fillColor: AppColor.whiteColor,
                                        showBottomErrorMsg: settingController.showBottomErrorMsg.value,
                                        controller:
                                            controller.confirmPassController,
                                        errorMsg: controller
                                            .confirmPassErrorMsg.value,
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.only(
                                            right: 15.w,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.show2.value =
                                                  !controller.show2.value;
                                            },
                                            child: Icon(
                                              controller.show2.value
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              CustomLoginButton(
                                title: 'CHANGE_PASSWORD'.tr.toUpperCase(),
                                onTap: () {
                                  controller
                                      .validationChangePassScreen(context);
                                },
                                isCancelButton: false,
                              ),
                              SizedBox(
                                height: 40.h,
                              ),
                            ],
                          ),
                        )));
              }),
            )
          ],
        ),
      ),
    );
  }
}
