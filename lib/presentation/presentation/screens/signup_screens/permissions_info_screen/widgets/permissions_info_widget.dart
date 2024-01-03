import 'package:finutss/domain/bloc/permissions_info_bloc/permissions_info_bloc.dart';
import 'package:finutss/domain/bloc/permissions_info_bloc/permissions_info_event.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/screens/signup_screens/permissions_info_screen/widgets/permission_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget permissions(BuildContext context) {
  return SafeArea(
    child: Padding(
      padding: EdgeInsets.only(left: 16.0.w, right: 16.w, top: 10.h),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: Colors.white,
              height: 29.h,
              width: double.infinity,
              child: Center(
                child: customText(text: 'APP_PERMISSIONS'.tr, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // size5,

          Expanded(
            child: Column(
              children: [
                SizedBox(height: 16.h),
                //size35,
                // size10,
                permissionsCard(
                    context: context,
                    title: "DEVICE_AND_APP_HISTORY".tr,
                    text: 'IMPROVE_SERVICE_AND_CHECK_FOR_ERRORS'.tr,
                    icon: Icons.phone_android_outlined,
                    isOptional: false),
                permissionsCard(
                    context: context,
                    title: "BLUETOOTH".tr,
                    text: "SENSOR_CONNECTION_FOR_MOVEMENT_PROGRESS".tr,
                    icon: Icons.bluetooth,
                    isOptional: false),
                permissionsCard(
                  context: context,
                  title: "NOTIFICATION".tr,
                  text: "PUSH_NOTIFICATION_AND_MESSAGE_RECEPTION_GUIDANCE".tr,
                  icon: Icons.notifications_none_outlined,
                ),
                permissionsCard(
                  context: context,
                  title: "PHOTO_CAMERA".tr,
                  text: "CHANGE_PROFILE_AND_UPLOAD_A_PICTURE_OF_YOUR".tr,
                  icon: Icons.camera_alt_outlined,
                ),
                permissionsCard(
                  context: context,
                  title: "MIC".tr,
                  text: "VOICE_CONVERSATION_BETWEEN_USERS".tr,
                  icon: Icons.mic,
                ),
                permissionsCard(
                  height: 85,
                  context: context,
                  title: "STORAGE".tr,
                  text: "CONTENT_STORAGE_FOR_SEAMLESS_SERVICE_PROVIDING".tr,
                  icon: Icons.folder_open_sharp,
                ),
                //size50,
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                children: [
                  Expanded(
                    child: customButton(
                        onTapFunction: () =>
                            BlocProvider.of<PermissionsInfoBloc>(context).add(
                                PermissionsInfoCheckPermission()),
                        fontWeight: FontWeight.bold,
                        height: 48,
                        radius: 15,
                        text: 'OK'.tr,
                        textSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}