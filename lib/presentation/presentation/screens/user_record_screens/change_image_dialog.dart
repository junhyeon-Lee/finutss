import 'dart:io';
import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/user_circle_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:image_picker/image_picker.dart';

class ChangeImageDialog extends StatelessWidget {
  final authController = Get.put(AuthController());
  File? _image;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return Scaffold(
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          // contentPadding: EdgeInsets.zero,
          // insetPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 48),
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.all(20.r),
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
                            Center(child: headingWidget(title: 'CHANGE_IMAGE'.tr)),
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
                        size65,
                        userAvatar(
                            imagePath: controller.user?.image?.url ?? AuthController.userProfileDefaultPath,
                            borderColor: colorTransparent,
                            height: 100,
                            width: 100),
                        size20,
                        customText(
                          text: 'CHANGE_THE_PROFILE_IMAGE'.tr,
                          textAlign: TextAlign.center,
                          fontColor: colorDarkGrey,
                          fontSize: 14,
                        ),
                        size50,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: customButton(
                                    text: 'DEFAULT'.tr,
                                    textSize: 16,
                                    height: 48,
                                    textColor: Color(0xff303443),
                                    color: Colors.transparent,
                                    fontWeight: FontWeight.w700,
                                    borderColor: Colors.grey,
                                    onTapFunction: () {
                                      ///TODO
                                     // authController.removeImage();
                                      return Get.back();
                                    }),
                              ),
                              size15,
                              Expanded(
                                child: customButton(
                                    text: 'ALBUM'.tr,
                                    textColor: Colors.white,
                                    textSize: 16,
                                    height: 48,
                                    fontWeight: FontWeight.w700,
                                    color: colorBlue,
                                    onTapFunction: () async {
                                      final ImagePicker _picker = ImagePicker();
                                      XFile? image = await _picker.pickImage(
                                          source: ImageSource.gallery, maxHeight: 512, maxWidth: 512);
                                      ///TODO
                                      authController.uploadImage(image!);
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
      },
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
}
