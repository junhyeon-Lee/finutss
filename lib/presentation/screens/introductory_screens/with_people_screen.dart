import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithPeopleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              'assets/images/with_people.png',
              width: 326.w,
              height: 270.h,

              // width: MediaQuery.of(context).size.width * 0.57,
            ),
            size65,
            /* ---------------------------------- title --------------------------------- */
            headingWidget(title: 'WITH_PEOPLE'.tr),
            size15,
            Center(
              child: customText(
                text: "WITH_PEOPLE_COTENT".tr,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
                fontColor: colorWhitish,
                // maxLines: 3,
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
