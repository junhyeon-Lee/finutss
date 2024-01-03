import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChangeNewPasswordScreen extends StatefulWidget {
  @override
  State<ChangeNewPasswordScreen> createState() => _ChangeNewPasswordScreenState();
}

class _ChangeNewPasswordScreenState extends State<ChangeNewPasswordScreen> {
  final AuthController authController = Get.put(AuthController());
  @override
  void dispose() {
    authController.clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 테스트용
    // authController.passwordTextController.text = '12341234';
    // authController.newPasswordTextController.text = '12qwaszx!';
    // authController.confirmPasswordTextController.text = '12qwaszx!';
    return Scaffold(
        appBar: simpleAppBar(text: 'CHANGE_PASSWORD'.tr) as PreferredSizeWidget?,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Form(
            key: authController.passwordFormKey,
            child: GetBuilder<AuthController>(builder: (authController) {
              return Column(
                children: [
                  size20,
                  /* ----------------------------- password field ----------------------------- */
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: customTextField(
                      errorText: authController.passwordErrorText,
                      label: 'PASSWORD'.tr,
                      isPasswordField: true,
                      isObscurePassword: authController.isObscurePassword,
                      textController: authController.passwordTextController,
                      // validator: authController.passwordValidator,
                      onObscureButtonPressed: () {
                        authController.passwordObscure();
                      },
                    ),
                  ),
                  SizedBox(height: 35.h),
                  /* --------------------------- new password field --------------------------- */
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: customTextField(
                      errorText: authController.newPasswordErrorText,
                      label: 'PLEASE_ENTER_A_NEW_PASSWORD'.tr,
                      isPasswordField: true,
                      isObscurePassword: authController.isObscureNewPassword,
                      textController: authController.newPasswordTextController,
                      // validator: authController.passwordValidator,
                      onObscureButtonPressed: () {
                        authController.newPasswordObscure();
                      },
                      focusNode: authController.focusNodeNewPasswordTextController
                    ),
                  ),
                  SizedBox(height: 35.h),
                  /* ----------------------------- confirm password field ----------------------------- */
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: customTextField(
                      errorText: authController.confirmPasswordErrorText,
                      label: 'CONFIRM_PASSWORD'.tr,
                      isPasswordField: true,
                      isObscurePassword: authController.isObscureConfirmPassword,
                      textController: authController.confirmPasswordTextController,
                      // validator: authController.confirmPasswordValidator,
                      onObscureButtonPressed: () {
                        authController.confirmPasswordObscure();
                      },
                      focusNode: authController.focusNodeConfirmPasswordTextController
                    ),
                  ),
                  size60,
                  /* --------------------------------- button --------------------------------- */
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: customButton(
                              height: 48,
                              textSize: 15,
                              text: "CHANGE_PASSWORD".tr,
                              fontWeight: FontWeight.bold,
                              onTapFunction: () {
                                // Get.dialog(ForgetPasswordDialog(),
                                //     barrierDismissible: false);
                                authController.passwordConfirmation('CHANGE'.tr, 'PASSWORD_CHANGE_COMPLETE_INFO'.tr);
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        )));
  }
}
