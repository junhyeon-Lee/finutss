import 'package:finutss/new%20ui/controller/login_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:finutss/new%20ui/widget/custom_auth_screen.dart';
import 'package:finutss/presentation/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VerificationScreen extends StatefulWidget {
  VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.green[100],
      ),
      child: CustomAuthScreen(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 35,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "VERIFICATION".tr,
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w700,
                        fontSize: 23.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "AFTER_SIGNING_UP_INFO".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.subTitleColor.withOpacity(0.5),
                        height: 1.3.h,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "VERIFICATION_CODE".tr,
                                style: TextStyle(
                                  color: AppColor.subTitleColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.sp,
                                ),
                              ),
                              Spacer(),
                              Bouncing(
                                duration: Duration(milliseconds: 100),
                                onPressed: () {
                                  loginController.getResendOTP();
                                },
                                child: Container(
                                  height: 24.h,
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColor.greenSliderBg,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "RE_SEND".tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.greenSliderBg,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          TextFormField(
                            textAlign: TextAlign.start,
                            obscuringCharacter: '*',
                            controller: loginController.verificationController,
                            keyboardType:  TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.fromLTRB(
                                10,
                                12.7,
                                10,
                                12.7,
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              suffixIconConstraints: BoxConstraints(
                                maxHeight: 35.h,
                              ),
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
                            height: 5.h,
                          ),
                          Obx(() => loginController.verificationErrorMsg.value.isEmpty ? SizedBox() : Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              loginController.verificationErrorMsg.value,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontFamily: 'MontserratItalic',
                                color: AppColor.errorTextColor,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                fontSize: 11.sp,
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 150.h,
                    ),
                    CancelSaveButton(
                      onTapSave: () {
                        loginController.validationVerification();
                      },
                      onTapCancel: () {
                        Navigation.pop();
                      },
                      saveTitle: "REPORT_DONE".tr,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
