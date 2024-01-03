import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/dummy_data_controller.dart';

import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/f2f_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/invite_friends_widgets/invite_friends_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';

class InviteFriendsScreen extends StatelessWidget {
  final f2fController = Get.put(F2FController());
  final authController = Get.put(AuthController());
  final DummyDataController dummyDataController = Get.put(DummyDataController());
  @override
  Widget build(BuildContext context) {
    f2fController.init();
    f2fController.callFollowerPaginate(authController.user?.userId);
    return GetBuilder<F2FController>(builder: (context) {
      return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  child: Column(children: [
                    size70,
                    size5,
                    for (var f2f in f2fController.docs)
                      Padding(
                        padding: EdgeInsets.only(left: 14.w, right: 14.w),
                        child: inviteFriendsCard(f2f),
                      )
                  ]),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 60.h,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 25.h, 16.w, 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Spacer(),
                        customText(
                          text: 'Invite Friends',
                          fontColor: colorDarkGrey,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        // Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 15.h, 16.w, 10.h),
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: colorBackgroundSilver,
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          CommunityMaterialIcons.window_close,
                          size: 24.r,
                          color: colorDarkGrey,
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
