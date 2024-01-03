import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FitnessScreen extends StatefulWidget {
  final Function onPressed;
  final bool? isCenterImage;
  final bottomAnimationTranslation;
  FitnessScreen({required this.onPressed, this.isCenterImage, required this.bottomAnimationTranslation});
  @override
  _FitnessScreenState createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AnimatedOpacity(
              opacity: !widget.isCenterImage! ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: !widget.isCenterImage! ? 270.h : 0.h,
                width: !widget.isCenterImage! ? 309.w : 0.w,
                child: Image.asset(
                  'assets/images/fitness.png',
                ),
              ),
            ),
            /* ---------------------------------- title --------------------------------- */
            Transform.translate(
              offset: Offset(0, widget.bottomAnimationTranslation.value),
              child: Column(
                children: [
                  size50,
                  headingWidget(
                    title: 'FITNESS_THAT_FITS_RIGHT'.tr,
                    size: 20.0,
                  ),
                  size10,
                  Center(
                    child: customText(
                      text: "FITNESS_THAT_FITS_RIGHT_COTENT".tr,
                      // maxLines: 3,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                      fontColor: colorWhitish,
                      height: 1.5,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  /* --------------------------------- button --------------------------------- */
                  size30,
                  Padding(
                    padding: EdgeInsets.only(left: 10.0.w, right: 10.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: customButton(
                              onTapFunction: widget.onPressed,
                              height: 48,
                              radius: 15,
                              fontWeight: FontWeight.bold,
                              text: "START_NOW".tr,
                              textSize: 16),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
