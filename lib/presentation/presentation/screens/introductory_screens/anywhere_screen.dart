import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnywhereScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 326.w,
            height: 270.h,
            child: Image.asset(
              'assets/images/anywhere.png',

              // width: MediaQuery.of(context).size.width * 0.57,
            ),
          ),
          size65,

          /* ---------------------------------- title --------------------------------- */
          headingWidget(
            title: 'ANYWHERE'.tr,
          ),
          size15,
          Center(
            child: customText(
              text: 'ANYWHERE_CONTENT'.tr,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              // maxLines: 3,
              overflow: TextOverflow.ellipsis,
              fontColor: colorWhitish,
              height: 1.5,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
