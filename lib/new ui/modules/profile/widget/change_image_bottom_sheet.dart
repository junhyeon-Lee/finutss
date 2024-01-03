import 'package:finutss/helper/toast_helper.dart';
import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/modules/profile/controller/edit_profile_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> ChangeImageBottomSheet(BuildContext context) {
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
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Spacer(),
            CloseButtonCustom(onTap: (){
              controller.pickPhotoPath.value = controller.avatarPath.value;
              Get.back();
            }),

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
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
                  top: 36.h,
                ),
                child: Column(
                  children: [
                    Text(
                      "CHANGE_IMAGE".tr.toUpperCase(),
                      style: TextStyle(
                        color: AppColor.blueTextColor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                      width: 112.w,
                      height: 112.w,
                      child: Stack(fit: StackFit.expand, children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Obx(
                                () => CustomCircleImageview(
                              width: 112.w,
                              borderSize: 1.9.w,
                              imagePath: controller.pickPhotoPath.value,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 5.w,
                          bottom: 5.w,
                          child: InkWell(
                            onTap: () async {
                              controller.avatarFromGallery();
                            },
                            child: CircleAvatar(
                              radius: 14.w,
                              backgroundColor: AppColor.circleAvatarBg,
                              child: Icon(
                                Icons.camera_alt,
                                color: AppColor.pink,
                                size: 15.w,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 22.h,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25.w,
                      ),
                      child: CancelSaveButton(
                        height: 37.h,
                        cancelTitle: "DEFAULT".tr.toUpperCase(),
                        onTapCancel: () {
                          controller.updateProfilePhoto(isDefault: true);
                        },
                        onTapSave: () {
                          if (controller.pickPhotoPath.value.isEmpty || controller.pickPhotoPath.value==controller.avatarPath.value) {
                            AppToast.showSnackBar(
                                title: '',
                                message: 'Please Select Profile Photo');
                          } else {
                            controller.updateProfilePhoto(isDefault: false);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 46.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
