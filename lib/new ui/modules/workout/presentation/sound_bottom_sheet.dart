import 'package:finutss/new%20ui/controller/login_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/controller/sound_controller.dart';
import 'package:finutss/new%20ui/modules/invite_friends/invite_friend_bottom_sheet.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/mode_select_bottom_sheet.dart';
import 'package:finutss/new%20ui/widget/round_button.dart';
import 'package:finutss/new%20ui/widget/seekbar_thumb_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:volume/volume.dart';

Future<void> workoutMenuBottomSheet(BuildContext context,{required String trackId}) {
  final SoundController controller = Get.put(SoundController());
  LoginController loginController=Get.find();

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
    backgroundColor: Colors.black.withOpacity(0.5),
    builder: (context) {
      Constants.isOpenScreen=true;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.whiteColor.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 2.w,
                        ),
                        SvgPicture.asset(IconAssets.lampIcon),
                        SizedBox(
                          width: 16.w,
                        ),
                        Expanded(
                          child: Text(
                            'TIP_001'.tr,
                            style: TextStyle(
                              height: 1.7,
                              color: AppColor.subTitleColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.whiteColor.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "   " + 'SOUND'.tr.toUpperCase(),
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColor.subTitleColor,
                              letterSpacing: 0.2),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => controller.micVolume.value != -1 &&
                                controller.micMaxVolume.value != -1
                            ? Container(
                                decoration: BoxDecoration(
                                  color: AppColor.whiteColor,
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.cardGradiant1
                                          .withOpacity(0.05),
                                      spreadRadius: 2,
                                      blurRadius: 15,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 11.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "MIC_VOLUME".tr,
                                      style: TextStyle(
                                        color: AppColor.blueTextColor,
                                        fontSize: 11.sp,
                                        letterSpacing: 0.2,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 11.h,
                                    ),
                                    SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        activeTrackColor:
                                            AppColor.lightBlueTextColor,
                                        inactiveTrackColor:
                                            AppColor.inActiveSliderBg,
                                        thumbColor: AppColor.lightBlueTextColor,
                                        activeTickMarkColor: Colors.transparent,
                                        inactiveTickMarkColor:
                                            Colors.transparent,
                                        overlayShape: RoundSliderOverlayShape(
                                            overlayRadius: 0),
                                        trackHeight: 3.2,
                                        trackShape: CustomTrackShape(),
                                        thumbShape: SeekBarThumbShape(
                                          thumbRadius: 7,
                                          roundness: 5,
                                          thickness: 2,
                                          color: AppColor.lightBlueTextColor,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.mic,
                                            color: AppColor.lightBlueTextColor,
                                          ),
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          Expanded(
                                            child: Slider(
                                                min: 0,
                                                max: controller
                                                        .micMaxVolume.value /
                                                    1.0,
                                                value: controller
                                                        .micVolume.value /
                                                    1.0,
                                                divisions: controller
                                                    .micMaxVolume.value,
                                                onChanged: (newValue) async {
                                                  await Volume.setVol(
                                                      newValue.toInt(),
                                                      showVolumeUI:
                                                          ShowVolumeUI.SHOW);
                                                  controller.updateVolumesMic();
                                                },
                                                onChangeStart: (value) async {
                                                  await Volume.controlVolume(
                                                      controller.audioManager!);
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox()),
                        SizedBox(
                          height: 7.h,
                        ),
                        Obx(() => controller.soundVolume.value != -1 &&
                                controller.soundMaxVolume.value != -1
                            ? Container(
                                decoration: BoxDecoration(
                                  color: AppColor.whiteColor,
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.cardGradiant1
                                          .withOpacity(0.05),
                                      spreadRadius: 2,
                                      blurRadius: 15,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 11.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "SOUND_EFFECT_VOLUME".tr,
                                      style: TextStyle(
                                        color: AppColor.blueTextColor,
                                        fontSize: 11.sp,
                                        letterSpacing: 0.2,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 11.h,
                                    ),
                                    SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        activeTrackColor: AppColor.purple,
                                        inactiveTrackColor:
                                            AppColor.inActiveSliderBg,
                                        thumbColor: AppColor.purple,
                                        activeTickMarkColor: Colors.transparent,
                                        inactiveTickMarkColor:
                                            Colors.transparent,
                                        overlayShape: RoundSliderOverlayShape(
                                            overlayRadius: 0),
                                        trackHeight: 3.2,
                                        trackShape: CustomTrackShape(),
                                        thumbShape: SeekBarThumbShape(
                                          thumbRadius: 7,
                                          roundness: 5,
                                          thickness: 2,
                                          color: AppColor.purple,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.volume_up_sharp,
                                            color:
                                                controller.soundVolume.value ==
                                                        0
                                                    ? AppColor.soundMuteColor
                                                    : AppColor.purple,
                                          ),
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          Expanded(
                                            child: Slider(
                                                min: 0,
                                                max: controller
                                                        .soundMaxVolume.value /
                                                    1.0,
                                                value:
                                                    controller
                                                            .soundVolume.value /
                                                        1.0,
                                                divisions: controller
                                                    .soundMaxVolume.value,
                                                onChanged: (newValue) async {
                                                  await Volume.setVol(
                                                      newValue.toInt(),
                                                      showVolumeUI:
                                                          ShowVolumeUI.SHOW);
                                                  controller
                                                      .updateVolumesSound();
                                                },
                                                onChangeStart: (value) async {
                                                  await Volume.controlVolume(
                                                      controller
                                                          .audioManagerSound!);
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoundButton(
                            iconPath: IconAssets.micIcon,
                            width: 48.w,
                            bgColor: AppColor.whiteColor.withOpacity(0.85),
                            iconColor: AppColor.blue, onTap: () {  },),
                        Obx(() => RoundButton(
                              iconPath: IconAssets.soundIcon,
                              width: 48.w,
                              bgColor: AppColor.whiteColor.withOpacity(0.85),
                              iconColor: controller.soundVolume.value == 0
                                  ? AppColor.soundMuteColor
                                  : AppColor.purple, onTap: () {  },
                            )),
                        RoundButton(
                          iconPath: loginController.getCurrentType(),
                          width: 48.w,
                          bgColor: AppColor.whiteColor.withOpacity(0.85),
                          iconColor: AppColor.pinkSlider, onTap: () {  },
                        ),
                        RoundButton(
                          iconPath: IconAssets.emailIcon,
                          width: 48.w,
                          bgColor: AppColor.whiteColor.withOpacity(0.85),
                          iconColor: AppColor.greenSliderBg,
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                opaque: false,
                                pageBuilder:
                                    (BuildContext context, _,
                                    __) =>
                                    InviteFriendScreen(trackId: trackId,),
                              ),
                            );
                          },
                        ),
                       /* RoundButton(
                          iconPath: IconAssets.removeUserIcon,
                          width: 50.w,
                          bgColor: AppColor.whiteColor.withOpacity(0.85),
                          iconColor: AppColor.darkPink,
                          onTap: () {
                            reportUserBottomSheet(context,title: "REPORT_USER");
                          },
                        ),*/
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: GestureDetector(
                        onTap: () {
                          Navigation.pop();
                        },
                        child: Image.asset(
                          IconAssets.closeRoundIcon,
                          width: 36.w,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );



}
