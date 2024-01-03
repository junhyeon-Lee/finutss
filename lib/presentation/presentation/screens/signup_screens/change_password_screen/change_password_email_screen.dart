import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordEmailScreen extends StatefulWidget {
  @override
  State<ChangePasswordEmailScreen> createState() =>
      _ChangePasswordEmailScreenState();
}

class _ChangePasswordEmailScreenState extends State<ChangePasswordEmailScreen> {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(text: 'CHANGE_PASSWORD'.tr) as PreferredSizeWidget?,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: authController.emailFormKey,
            child: Column(
              children: [
                size20,
                /* ------------------------------- email field ------------------------------ */
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  child: customTextField(
                    errorText: authController.emailErrorText,
                    label: 'Email',
                    textController: authController.emailTextController,
                    onSave: (email) {
                      authController.email = email;
                    },
                  ),
                ),
                size50,
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: customText(
                      text: "EMAIL_AUTHENTICATION_GUIDE".tr,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                      height: 2),
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
                            textSize: 15,
                            text: "SEND".tr,
                            fontWeight: FontWeight.w700,
                            onTapFunction: () {
                              setState(() {
                                authController.emailVerification();
                              });
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
