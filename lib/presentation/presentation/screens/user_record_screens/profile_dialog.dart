import 'package:community_material_icon/community_material_icon.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/presentation/screens/setting_page/my_page/my_page.dart';
import 'package:finutss/presentation/screens/user_record_screens/change_image_dialog.dart';
import 'package:finutss/presentation/screens/user_record_screens/edit_info_dialog.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/user_circle_avatar.dart';
import 'package:finutss/presentation/widgets/social_page_widgets/profile_information_card_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ProfileDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return Scaffold(
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          // contentPadding: EdgeInsets.zero,
          // insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 48),
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.all(20.0.r),
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
                            Center(child: headingWidget(title: 'PROFILE'.tr)),
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
                        InkWell(
                          onTap: () {
                            Get.to(ProfileInformationCardImage());
                          },
                          child: userAvatar(
                              imagePath: controller.user?.image?.url ??
                                  AuthController.userProfileDefaultPath,
                              borderColor: colorTransparent,
                              height: 100,
                              width: 100),
                        ),
                        size20,
                        customText(
                          text: controller.user != null
                              ? controller.user!.username
                              : "",
                          textAlign: TextAlign.center,
                          fontColor: colorWhitish,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        size15,
                        Padding(
                          padding: EdgeInsets.only(left: 25.w, right: 25.w),
                          child: customText(
                            height: 1.5,
                            text: controller.user != null
                                ? controller.user?.biography != null
                                    ? controller.user?.biography as String
                                    : ""
                                : "",
                            textAlign: TextAlign.center,
                            fontColor: colorDarkGrey,
                            fontSize: 14,
                          ),
                        ),
                        size25,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            grayContainer(
                                text: 'PHOTO'.tr,
                                image: 'assets/images/camera.png',
                                onTap: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return SafeArea(
                                            child: Padding(
                                          padding: EdgeInsets.only(top: 40.0.h),
                                          child: ChangeImageDialog(),
                                        ));
                                      });
                                  // Get.dialog(ChangeImageDialog(),
                                  //     barrierDismissible: false);
                                }),
                            size15,
                            grayContainer(
                                text: 'EDIT_INFO'.tr,
                                image: 'assets/images/edit_gray.png',
                                onTap: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return SafeArea(
                                            child: Padding(
                                          padding: EdgeInsets.only(top: 40.0.h),
                                          child: EditInfoDialog(),
                                        ));
                                      });
                                  // Get.dialog(EditInfoDialog(),
                                  //     barrierDismissible: false);
                                }),
                            size15,
                            grayContainer(
                              text: 'MY_PAGE'.tr,
                              image: 'assets/images/my_page.png',
                              onTap: () {
                                print("My page tap");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MyPage(),
                                  ),
                                );
                              },
                            ),
                          ],
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
              height: 100.r,
              width: 100.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: colorBackgroundSilver,
              ),
              padding: EdgeInsets.all(18.r),
              child: Image.asset(
                image,
                width: 100.r,
                height: 100.r,
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
