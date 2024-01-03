import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar_signup.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_textfield.dart';
import 'package:finutss/presentation/widgets/signin_signup_widget/social_account_row.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBarSignUp(
        text: 'SIGN_UP'.tr,
      ) as PreferredSizeWidget?,
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<AuthController>(builder: (authController) {
            return Form(
              key: authController.signUpFormKey,
              child: Column(
                children: [
                  size20,
                  Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: customText(
                        text: 'START_QUICKLY_WITH_YOUR_SOCIAL_ACCOUNT'.tr,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.visible,
                        fontColor: colorWhitish,
                        height: 1,
                        textAlign: TextAlign.center,
                      )),
                  size10,
                  /* ----------------------------- social accounts ---------------------------- */
                  socialAccountRow(context: context),
                  size10,
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Divider(
                          thickness: 1.5,
                        )),
                        size10,
                        customText(
                          text: 'OR_SIGN_UP_WITH_EMAIL'.tr,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.visible,
                          fontColor: colorWhitish,
                          height: 2,
                          textAlign: TextAlign.center,
                        ),
                        size10,
                        Expanded(child: Divider(thickness: 1.5)),
                      ],
                    ),
                  ),
                  size10,
                  /* ------------------------------- user name field ------------------------------ */
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: customTextField(
                      errorText: authController.userNameErrorText,
                      label: 'USER_NAME'.tr,
                      textController: authController.userNameTextController,
                      // validator: authController.userNameValidator,
                      onSave: (userName) {
                        authController.userName = userName;
                      },
                      focusNode: authController.focusNodeUserNameTextController
                    ),
                  ),
                  size5,
                  /* ------------------------------- email field ------------------------------ */
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: customTextField(
                      errorText: authController.emailErrorText,
                      label: 'EMAIL'.tr,
                      textController: authController.emailTextController,
                      // validator: authController.emailValidator,
                      onSave: (email) {
                        authController.email = email;
                      },
                      focusNode: authController.focusNodeEmailTextController,
                    ),
                  ),
                  size5,
                  /* ----------------------------- password field ----------------------------- */
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: customTextField(
                      errorText: authController.passwordErrorText,
                      label: 'PASSWORD'.tr,
                      isObscurePassword: authController.isObscurePassword,
                      isPasswordField: true,
                      textController: authController.passwordTextController,
                      // validator: authController.passwordValidator,
                      onSave: (password) {
                        authController.password = password;
                      },
                      onObscureButtonPressed: () {
                        authController.passwordObscure();
                      },
                      focusNode:authController.focusNodePasswordTextController,
                    ),
                  ),
                  size5,
                  /* ----------------------------- confirm password field ----------------------------- */
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: customTextField(
                      errorText: authController.confirmPasswordErrorText,
                      label: 'CONFIRM_PASSWORD'.tr,
                      isPasswordField: true,
                      textController: authController.confirmPasswordTextController,
                      // validator: authController.passwordValidator,
                      isObscurePassword: authController.isObscureConfirmPassword,
                      onSave: (confirmPassword) {
                        authController.confirmPassword = confirmPassword;
                      },
                      onObscureButtonPressed: () {
                        authController.confirmPasswordObscure();
                      },
                      focusNode: authController.focusNodeConfirmPasswordTextController
                    ),
                  ),
                  size10,
                  /* --------------------------------- button --------------------------------- */
                  Padding(
                    padding: EdgeInsets.only(left: 16.0.w, right: 16.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: customButton(
                              height: 48,
                              textSize: 16,
                              radius: 15,
                              text: "NEXT".tr,
                              fontWeight: FontWeight.w700,
                              onTapFunction: () {
                                authController.signUp();
                              }),
                        ),
                      ],
                    ),
                  ),
                  size10
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
