import 'package:finutss/domain/controller/tutorial_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/action_card.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/rounded_decoration.dart';
import 'package:finutss/presentation/widgets/dialogs/tutorial/tutorial_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserGuideListScreen extends StatelessWidget {
  final TutorialController _tutorialController = Get.put(TutorialController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundSilver,
      appBar: simpleAppBar(text: 'USER_GUIDE'.tr) as PreferredSizeWidget?,
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(16.r),
            padding: EdgeInsets.all(16.r),
            decoration: roundedDecoration(),
            child: Column(
              children: [
                /* ------------------------------ action cards ------------------------------ */
                size15,
                actionCard(
                    heading: 'TUTORIAL_1_TITLE_SENSOR'.tr,
                    onTapFunction: () {
                      // _tutorialController.guideIndex = 0;
                      // _tutorialController.userGuideFromSettings = true;
                      //_tutorialController.guideIndex = 0;
                      //_tutorialController.assignGuideValue(0);
                      _tutorialController.valueToAssignGuideAndGuideIndex(0, fromSettings: true);
                      Get.dialog(TutorialDialog(), barrierDismissible: false);
                    }),
                size15,
                actionCard(
                    heading: 'TUTORIAL_2_TITLE_WORKOUT'.tr,
                    onTapFunction: () {
                      _tutorialController.valueToAssignGuideAndGuideIndex(1, fromSettings: true);
                      Get.dialog(TutorialDialog(), barrierDismissible: false);
                    }),
                size15,
                actionCard(
                    heading: 'TUTORIAL_3_TITLE_BODY_INFO'.tr,
                    onTapFunction: () {
                      _tutorialController.valueToAssignGuideAndGuideIndex(2, fromSettings: true);
                      Get.dialog(TutorialDialog(), barrierDismissible: false);
                    }),
                size15,
                actionCard(
                    heading: 'TUTORIAL_4_TITLE_RECORD'.tr,
                    onTapFunction: () {
                      _tutorialController.valueToAssignGuideAndGuideIndex(3, fromSettings: true);
                      Get.dialog(TutorialDialog(), barrierDismissible: false);
                    }),
                size15,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
