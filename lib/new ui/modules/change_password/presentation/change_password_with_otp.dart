import 'package:finutss/new%20ui/modules/change_password/controller/forgot_password_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_auth_screen.dart';
import 'package:finutss/new%20ui/widget/custom_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ChangePasswordWithOTP extends StatefulWidget {
  ChangePasswordWithOTP({Key? key}) : super(key: key);

  @override
  State<ChangePasswordWithOTP> createState() => _ChangePasswordWithOTPState();
}

class _ChangePasswordWithOTPState extends State<ChangePasswordWithOTP> {
  ForgotPasswordController controller = Get.put(ForgotPasswordController());

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAuthScreen(
      showBackIcon: true,
      child: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 36.h,
                      ),
                      Title(),
                      SizedBox(
                        height: 9.h,
                      ),
                      Text(
                        "EMAIL_AUTHENTICATION_GUIDE".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'MontserratItalic',
                            color: AppColor.subTitleColor.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                            fontSize: 11.5.sp,
                            height: 1.8),
                      ),
                      SizedBox(
                        height: 47.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "EMAIL".tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColor.subTitleColor, fontWeight: FontWeight.w400, fontSize: 13.sp, height: 1.8),
                          ),
                          Obx(
                            () => InkWell(
                              onTap: () {
                                if (controller.isValidEmail.value) {
                                  controller.sendOTP();
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.9,
                                      color: controller.isValidEmail.value ? AppColor.green : AppColor.green.withOpacity(0.4),
                                    ),
                                    borderRadius: BorderRadius.circular(6.4)),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                                child: Text(
                                  controller.sendTitle.value.tr,
                                  style: TextStyle(
                                      color: controller.isValidEmail.value ? AppColor.green : AppColor.green.withOpacity(0.4),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.sp),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => textField(
                          editingController: controller.emailController,
                          hintText: 'PLEASE_ENTER_YOUR_EMAIL',
                          textType: TextInputType.emailAddress,
                          errorMsg: controller.emailErrorMsg.value,
                          onChanged: (val) {
                            controller.emailValidation();
                          },
                        ),
                      ),
                      Obx(() => Visibility(
                            visible: controller.sendTitle.value == 'SENT' ? true : false,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "SENT_YOU_AN_EMAIL_IF_YOU_DONT_SEE_THE_EMAIL_CHECK_THE_TRASH_SPAM_ADBOX_ETC".tr,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'MontserratItalic',
                                  color: AppColor.emailBoxColor,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.2,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 39.h,
                      ),
                      Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "VERIFICATION_CODE".tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColor.subTitleColor, fontWeight: FontWeight.w400, fontSize: 13.sp, height: 1.8),
                          ),
                          controller.isValidOTP.value
                              ? Text(
                            "BLOCK_DONE".tr,
                            style: TextStyle(
                              fontFamily: 'MontserratItalic',
                              color: AppColor.green,
                              fontWeight: FontWeight.w400,
                              fontSize: 11.sp,
                            ),
                          )
                              : controller.isShowTimer.value ? Obx(() => Text(
                            "00:"+controller.countSecond.value.toString().padLeft(2, '0'),
                            style: TextStyle(
                              fontFamily: 'MontserratItalic',
                              color: controller.countSecond.value.toString()=='0' ? AppColor.red : AppColor.green,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),) : SizedBox()
                          /*Countdown(
                                      animation: StepTween(
                                        begin: controller.totalReminderSecond, // THIS IS A USER ENTERED NUMBER
                                        end: 0,
                                      ).animate(controller.timeController!),
                                    ),*/
                        ],
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => textField(
                          editingController: controller.otpController,
                          hintText: 'PLEASE_ENTER_YOUR_VERIFICATION_NUMBER',
                          textType: TextInputType.number,
                          errorMsg: controller.otpErrorMsg.value,
                          enable: controller.isEnableOTPTextfield.value,
                          maxLength: 6,
                          onChanged: (val) {
                            if (val.length < 6) {
                              controller.otpErrorMsg.value = 'VERIFICATION_NUMBER_IS_INCORRECT'.tr;
                            } else {
                              controller.otpErrorMsg.value = '';
                              controller.verifyOTP();
                            }
                          },
                          format: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: Obx(() => CustomLoginButton(
                              height: 40.h,
                              fontsize: 15.sp,
                              showShadow: true,
                              bgColor: controller.isValidOTP.value ? AppColor.orangeColor : AppColor.disableBtnColor,
                              onTap: () {
                                if (controller.isValidOTP.value) {
                                  Navigation.replace(Routes.createPassword, arguments: {
                                    'token': controller.passwordToken,
                                    'email': controller.emailController.text.trim()
                                  });
                                }
                              },
                              title: 'VERIFICATION'.tr.toUpperCase(),
                              isCancelButton: true,
                            )),
                      ),
                      SizedBox(
                        height: 90.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget textField(
      {required TextEditingController editingController,
      required String hintText,
      required TextInputType textType,
      required ValueChanged<String> onChanged,
      required String errorMsg,
        bool? enable,
      List<TextInputFormatter>? format,
      int? maxLength}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          textAlign: TextAlign.start,
          maxLength: maxLength ?? null,
          maxLines: 1,
          enabled: enable?? true,
          obscureText: false,
          onChanged: onChanged,
          controller: editingController,
          autofocus: false,
          keyboardType: textType,
          inputFormatters: format ?? [],
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13.sp,
          ),
          decoration: InputDecoration(
            hintStyle:
                TextStyle(color: AppColor.alreadyTextColor.withOpacity(0.6), fontSize: 11.5.sp, fontWeight: FontWeight.w500),
            hintText: hintText.tr,
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(
              15,
              12.5,
              15,
              12.5,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            suffixIcon: null,
            suffixIconConstraints: BoxConstraints(
              maxHeight: 35.h,
            ),
            counterText: '',
            fillColor: AppColor.textFieldColor,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  8,
                ),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  8,
                ),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  8,
                ),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  8,
                ),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  8,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Text(
          errorMsg ?? "",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: 'MontserratItalic',
            color: AppColor.errorTextColor,
            fontWeight: FontWeight.w400,
            fontSize: 11.sp,
          ),
        )
      ],
    );
  }

  Widget Title() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        'CHANGE_PASSWORD'.tr.toUpperCase(),
        style: TextStyle(
          color: AppColor.subTitleColor,
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
        ),
      ),
    );
  }
}
