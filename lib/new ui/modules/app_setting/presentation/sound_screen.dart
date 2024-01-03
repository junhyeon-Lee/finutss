import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/controller/sound_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/widget/mode_select_bottom_sheet.dart';
import 'package:finutss/new%20ui/widget/seekbar_thumb_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:volume/volume.dart';

class SoundScreen extends StatelessWidget {
  final SoundController controller = Get.put(SoundController());

  SoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomSettingRow(
              title: 'SOUND'.tr.toUpperCase(),
              horizontalPadding: 20.w,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 16.h,
                    ),
                    Obx(() => controller.micMaxVolume.value != -1 &&
                            controller.micVolume.value != -1
                        ? Container(
                            decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(
                                11,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColor.cardGradiant1.withOpacity(0.05),
                                  spreadRadius: 2,
                                  blurRadius: 15,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 18.w,
                                vertical: 14.h,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "MIC_VOLUME".tr,
                                    style: TextStyle(
                                      color: AppColor.blueTextColor,
                                      fontSize: 15.sp,
                                      letterSpacing: 0.2,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor:
                                          AppColor.lightBlueTextColor,
                                      inactiveTrackColor:
                                          AppColor.inActiveSliderBg,
                                      thumbColor: AppColor.lightBlueTextColor,
                                      activeTickMarkColor: Colors.transparent,
                                      inactiveTickMarkColor: Colors.transparent,
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
                                            max: controller.micMaxVolume.value /
                                                1.0,
                                            value: controller.micVolume.value /
                                                1.0,
                                            divisions:
                                                controller.micMaxVolume.value,
                                            onChanged: (newValue) async {
                                              await Volume.setVol(
                                                  newValue.toInt(),
                                                  showVolumeUI:
                                                      ShowVolumeUI.SHOW);
                                              controller.updateVolumesMic();
                                            },
                                            onChangeStart: (value) async {
                                              await Volume.controlVolume(
                                                controller.audioManager!,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container()),
                    SizedBox(
                      height: 14.h,
                    ),
                    Obx(() {
                      return controller.soundMaxVolume.value != -1 &&
                              controller.soundVolume.value != -1
                          ? Container(
                              decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(
                                  11,
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
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 18.w,
                                  vertical: 16.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "SOUND_EFFECT_VOLUME".tr,
                                      style: TextStyle(
                                        color: AppColor.blueTextColor,
                                        fontSize: 15.sp,
                                        letterSpacing: 0.2,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.h,
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
                                            color: AppColor.purple,
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
                              ),
                            )
                          : SizedBox();
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
