import 'package:finutss/new%20ui/modules/profile/controller/edit_profile_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:finutss/new%20ui/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

/*

class EditBottomSheet extends StatelessWidget {
  EditBottomSheet({Key? key}) : super(key: key);
  final EditProfileController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.black.withOpacity(0.5),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
          height: MediaQuery.of(context).size.height * 2,
          width: MediaQuery.of(context).size.width,
          child: SizedBox(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: EdgeInsets.only(right: 14.w),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Image.asset(
                                  IconAssets.close,
                                  scale: 4,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.elliptical(
                                MediaQuery.of(context).size.width,
                                74.0,
                              ),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 10.w,
                              right: 10.w,
                              top: 37.h,
                            ),
                            child:Column(
                              children: [
                                Text(
                                  "EDIT".tr,
                                  style: TextStyle(
                                    color: AppColor.blueTextColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 35.h,
                                ),
                                Obx(
                                      () => CustomTextField(
                                    controller: controller.nickNameController,
                                    title: "NICKNAME".tr,
                                    errorMsg: controller.nickNameErrorMsg.value,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'EDIT_INFO'.tr,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: AppColor.subTitleColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 7.h,
                                ),
                                TextFormField(
                                  controller: controller.bioController,
                                  maxLength: 60,
                                  buildCounter: (context,
                                      {required currentLength,
                                        required isFocused,
                                        maxLength}) {
                                    return Container(
                                      transform: Matrix4.translationValues(
                                          0, -32.h, 0),
                                      child: Text(
                                        "$currentLength/$maxLength",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.blueTextColor
                                              .withOpacity(
                                            0.7,
                                          ),
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                    );
                                  },
                                  maxLines: 6,
                                  textAlign: TextAlign.start,
                                  obscuringCharacter: '*',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      height: 1.8,
                                      fontSize: 12.sp,
                                      color: AppColor.subTitleColor),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(
                                      18.w,
                                      25.h,
                                      16.w,
                                      0.w,
                                    ),
                                    isDense: true,
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
                                  height: 45.h,
                                ),
                                CancelSaveButton(
                                  height: 37.h,
                                  saveTitle: "UPDATE".tr.toUpperCase(),
                                  onTapSave: () {
                                    controller.validationUserName(context);
                                  },
                                  onTapCancel: () {
                                    controller.nickNameController.text=controller.nickName.value;
                                    controller.bioController.text=controller.bio.value;
                                    Navigation.pop();
                                  },
                                ),
                                SizedBox(
                                  height: 44.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

*/

Future<void> EditBottomSheet(BuildContext context) {
  final EditProfileController controller = Get.find();

  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    enableDrag: false,
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.black.withOpacity(0.2),
    builder: (context) {
      controller.keyboardIsVisible(context);
      return Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        height: MediaQuery.of(context).size.height * 2,
        width: MediaQuery.of(context).size.width,
        child: SizedBox(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: EdgeInsets.only(right: 14.w),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                IconAssets.close,
                                scale: 4,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.elliptical(
                              MediaQuery.of(context).size.width,
                              74.0,
                            ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10.w,
                            right: 10.w,
                            top: 37.h,
                          ),
                          child:Column(
                            children: [
                              Text(
                                "EDIT".tr,
                                style: TextStyle(
                                  color: AppColor.blueTextColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 35.h,
                              ),
                              Obx(
                                    () => CustomTextField(
                                  controller: controller.nickNameController,
                                  title: "NICKNAME".tr,
                                  errorMsg: controller.nickNameErrorMsg.value,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'EDIT_INFO'.tr,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: AppColor.subTitleColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              TextFormField(
                                controller: controller.bioController,
                                maxLength: 60,
                                buildCounter: (context,
                                    {required currentLength,
                                      required isFocused,
                                      maxLength}) {
                                  return Container(
                                    transform: Matrix4.translationValues(
                                        0, -32.h, 0),
                                    child: Text(
                                      "$currentLength/$maxLength",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.blueTextColor
                                            .withOpacity(
                                          0.7,
                                        ),
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  );
                                },
                                maxLines: 6,
                                textAlign: TextAlign.start,
                                obscuringCharacter: '*',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    height: 1.8,
                                    fontSize: 12.sp,
                                    color: AppColor.subTitleColor),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(
                                    18.w,
                                    25.h,
                                    16.w,
                                    0.w,
                                  ),
                                  isDense: true,
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
                                height: 45.h,
                              ),


                              Obx(() => controller.cancelUpdateButtonVisible.value ? Column(
                                children: [
                                  CancelSaveButton(
                                    height: 37.h,
                                    saveTitle: "UPDATE".tr.toUpperCase(),
                                    onTapSave: () {
                                      controller.validationUserName(context);
                                    },
                                    onTapCancel: () {
                                      controller.nickNameController.text=controller.nickName.value;
                                      controller.bioController.text=controller.bio.value;
                                      Navigation.pop();
                                    },
                                  ),
                                  SizedBox(
                                    height: 44.h,
                                  ),
                                ],
                              ) : SizedBox()),

                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      );
    },
  );
}

Widget startButton({VoidCallback? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: AppColor.orangeColor,
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30.w,
          vertical: 12.h,
        ),
        child: Center(
          child: Text(
            "UPDATE".tr,
            style: TextStyle(
              color: AppColor.whiteColor,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.04,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget CancelButton() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        12,
      ),
      border: Border.all(
        width: 1.5,
        color: AppColor.cancelButtonBg,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
      child: Center(
        child: Text(
          'CANCEL'.tr,
          style: TextStyle(
            color: AppColor.cancelButtonColor,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.04,
            fontSize: 14.sp,
          ),
        ),
      ),
    ),
  );
}
