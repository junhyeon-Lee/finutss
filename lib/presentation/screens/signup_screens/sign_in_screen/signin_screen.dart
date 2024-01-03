import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/presentation/screens/signup_screens/change_password_screen/change_password_email_screen.dart';
import 'package:finutss/presentation/screens/signup_screens/sign_up_screen/signup_screen.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_textfield.dart';
import 'package:finutss/presentation/widgets/dialogs/signup_dialog/login_as_guest_dialog.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:finutss/presentation/widgets/signin_signup_widget/social_account_row.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<AuthController>(builder: (authController) {
            return Form(
              child: Column(
                children: [
                  size30,
                  Center(
                      child: Image.asset(
                    'assets/images/logo.png',
                    height: 45.h,
                  )),
                  SizedBox(
                    height: 24.h,
                  ),
                  /* ----------------------------- title and text ----------------------------- */
                  headingWidget(
                    title: 'SIGN_IN'.tr,
                    size: 24,
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: customText(
                      text: 'START_QUICKLY_WITH_YOUR_SOCIAL_ACCOUNT'.tr,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      fontColor: colorWhitish,
                      height: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  /* ----------------------------- social accounts ---------------------------- */
                  socialAccountRow(context: context),
                  SizedBox(
                    height: 24.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Divider(
                          thickness: 1.5,
                        )),
                        SizedBox(
                          width: 13.w,
                        ),
                        customText(
                          text: 'OR_SIGN_IN_WITH_EMAIL'.tr,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.visible,
                          fontColor: colorWhitish,
                          height: 1,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: 13.w,
                        ),
                        Expanded(child: Divider(thickness: 1.5)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  /* ------------------------------- email field ------------------------------ */
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: customTextField(
                      errorText: authController.emailErrorText,
                      label: 'EMAIL'.tr,
                      textController: authController.emailTextController,
                      onSave: (email) {
                        authController.email = email;
                      },
                      focusNode: authController.focusNodeEmailTextController,
                    ),
                  ),
                  SizedBox(height: 14.h),

                  /* ----------------------------- password field ----------------------------- */
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: customTextField(
                      label: 'PASSWORD'.tr,
                      errorText: authController.passwordErrorText,
                      isPasswordField: true,
                      isObscurePassword: authController.isObscurePassword,
                      textController: authController.passwordTextController,
                      // validator: authController.passwordValidator,
                      onObscureButtonPressed: () {
                        authController.passwordObscure();
                      },
                      onSave: (password) {
                        authController.password = password;
                      },
                      focusNode: authController.focusNodePasswordTextController,
                    ),
                  ),
                  SizedBox(height: 6.h),

                  /* ----------------------------- forgot password ---------------------------- */
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: _textInkWell(
                          text: 'FORGOT_PASSWORD'.tr,
                          context: context,
                          width: 120.w,
                          onTapFunction: () {
                            authController.emailTextController.clear();
                            authController.passwordTextController.clear();
                            Get.to(() => ChangePasswordEmailScreen());
                          },
                        ),
                      )),
                  SizedBox(height: 30.h),

                  /* --------------------------------- button --------------------------------- */
                  Padding(
                    padding: EdgeInsets.only(left: 16.0.w, right: 16.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: customButton(
                              //height: MediaQuery.of(context).size.height / 15,
                              height: 48,
                              textSize: 16,
                              fontWeight: FontWeight.w700,
                              text: "SIGN_IN".tr,
                              onTapFunction: () {
                                print('login button pressed---------');
                                authController.login();
                              }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),

                  /* ---------------------------- sign up for email --------------------------- */
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textInkWell(
                          text: 'SIGN_UP'.tr,
                          context: context,
                          onTapFunction: () {
                            authController.emailTextController.clear();
                            authController.passwordTextController.clear();
                            Get.to(() => SignUpScreen());
                          },
                          width: 100.w,
                        ),
                        /* ----------------------------- login as guest ----------------------------- */
                        _textInkWell(
                          context: context,
                          text: 'AS_GUEST'.tr,
                          width: 105.w,
                          onTapFunction: () {
                            authController.emailTextController.clear();
                            authController.passwordTextController.clear();
                            Get.dialog(LoginAsGuestDialog(), barrierDismissible: false);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _textInkWell({onTapFunction, String text = '', double? width, context}) {
    return InkWell(
      onTap: onTapFunction,
      child: Container(
        width: width,
        child: Column(
          children: [
            Row(
              children: [
                customText(text: text, fontColor: colorDarkGrey, fontSize: 12, fontWeight: FontWeight.w500),
              ],
            ),
            Divider(
              color: colorDarkGrey,
              thickness: 1.5,
            ),
          ],
        ),
      ),
    );
  }
}
