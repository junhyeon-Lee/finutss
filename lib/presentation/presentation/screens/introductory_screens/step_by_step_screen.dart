import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepByStepScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              'assets/images/step_by_step.png',
              width: 326.w,
              height: 270.h,
            ),
            size65,
            /* ---------------------------------- title --------------------------------- */
            headingWidget(title: 'STEP_BY_STEP'.tr),
            size15,
            Center(
              child: customText(
                text: "STEP_BY_STEP_COTENT".tr,
                // maxLines: 3,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
                fontColor: colorWhitish,
                height: 1.5,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
