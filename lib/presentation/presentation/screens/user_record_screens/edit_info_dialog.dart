import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';

class EditInfoDialog extends StatefulWidget {
  @override
  _EditInfoDialog createState() => _EditInfoDialog();
  static GlobalKey<FormState> _loginScreenFormKey = GlobalKey<FormState>();
}

class _EditInfoDialog extends State<EditInfoDialog> {
  final authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    authController.memoTextController.text = authController.user?.biography ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      // contentPadding: EdgeInsets.zero,
      // insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 48),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 20.0.h),
        child: Container(
            height: 650.h,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    size15,
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(child: headingWidget(title: 'EDIT_INFO'.tr)),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
                            radius: 20.r,
                            backgroundColor: colorBackgroundSilver,
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                  /*Get.back();
                                      Get.back();*/
                                },
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  CommunityMaterialIcons.window_close,
                                  size: 24.r,
                                  color: colorDarkGrey,
                                )),
                          ),
                        ),
                      ],
                    ),
                    size55,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: colorBackgroundSilver,
                      ),
                      child: TextField(
                        controller: authController.memoTextController,
                        maxLength: 60,
                        minLines: 10,
                        maxLines: 12,
                        onChanged: (value) {

                        },
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintMaxLines: 100,
                          hintText: 'INTRODUCTION_INFORMATION_GUIDE'.tr,
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            color: colorWhitish,
                            fontWeight: FontWeight.w600,
                          ),
                          contentPadding: EdgeInsets.only(left: 15.w, top: 15.h, right: 15.w),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                       focusNode: authController.focusNodeMemoTextController
                      ),
                    ),
                    /*Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: backgroundSilverColor,
                      ),
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        children: [
                          customText(
                            text: 'Please refrain from doing anything that may offend other users and observe the Community Guide.',
                            textAlign: TextAlign.start,
                            fontColor: whitishColor,
                            fontSize: 14,
                          ),
                        ],
                      ),
                    ),
                    size20,
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          hintText: 'Please refrain from doing anything that may offend other users and observe the Community Guide.'
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 1,//Normal textInputField will be displayed
                      maxLines: 5,
                    ),*/
                    size50,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: customButton(
                                text: 'CANCEL'.tr,
                                textSize: 16,
                                height: 48,
                                textColor: Color(0xff303443),
                                color: Colors.transparent,
                                fontWeight: FontWeight.w700,
                                borderColor: Colors.grey,
                                onTapFunction: () {
                                  return Get.back();
                                }),
                          ),
                          size15,
                          Expanded(
                            child: customButton(
                                text: 'SAVE'.tr,
                                textColor: Colors.white,
                                textSize: 16,
                                height: 48,
                                fontWeight: FontWeight.w700,
                                color: colorBlue,
                                onTapFunction: () {
                                  EditInfoDialog._loginScreenFormKey.currentState?.save();
                                  authController.callApiUpdateUserBiography(authController.memoTextController.text.trim());
                                  Get.back();
                                }),
                          )
                        ],
                      ),
                    ),
                    size25,
                  ],
                ),
              ),
            )),
      ),
    );
  }

  grayContainer({
    Function? onTap,
    required String image,
    required String text,
  }) {
    return Flexible(
      child: Column(
        children: [
          InkWell(
            onTap: onTap as void Function()?,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: colorBackgroundSilver,
              ),
              padding: EdgeInsets.all(18.r),
              child: Image.asset(
                image,
                scale: 1.2,
              ),
            ),
          ),
          size10,
          customText(
            textAlign: TextAlign.center,
            text: text,
            fontColor: colorDarkGrey,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}
