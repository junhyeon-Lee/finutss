import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar_signup.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpSocialScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBarSignUp(
        text: 'SignUp',
      ) as PreferredSizeWidget?,
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<AuthController>(builder: (authController) {
            return Form(
              key: authController.signUpFormKey,
              child: Column(
                children: [
                  size20,
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
                                authController.signUpSocial();
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
