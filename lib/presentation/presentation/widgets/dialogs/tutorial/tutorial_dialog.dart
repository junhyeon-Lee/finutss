import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/tutorial_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TutorialDialog extends StatefulWidget {
  @override
  _TutorialDialogState createState() => _TutorialDialogState();
}

class _TutorialDialogState extends State<TutorialDialog> with SingleTickerProviderStateMixin {
  final tutorialController = Get.put(TutorialController());
  late AnimationController _controller;
  bool isLoading = false;

  @override
  void initState() {
    print("Dialog Created");
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.repeat();
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    print("Dialog Disposed");
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TutorialController>(
        init: tutorialController,
        builder: (controller) {
          return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
              contentPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.only(right: 16.w, left: 16.w, top: 230.h, bottom: 18.h),
              backgroundColor: Colors.white,
              content: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: TutorialDetails(
                    tutorialController: controller,
                  )));
        });
  }
}

class TutorialDetails extends StatelessWidget {
  final TutorialController? tutorialController;
  TutorialDetails({this.tutorialController});

  @override
  Widget build(BuildContext context) {
    print("tutorialIndex ${tutorialController!.tutorialIndex}");
    return Container(
      width: 342.w,
      height: 550.h,
      child: (tutorialController!.tutorials == null)
          ? SizedBox()
          : Column(
              children: [
                size10,
                headingWidget(title: tutorialController!.tutorials![tutorialController!.tutorialIndex].title.tr),
                size15,
                // image
                Container(
                    width: 299.w,
                    height: 189.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              tutorialController!.tutorials![tutorialController!.tutorialIndex].imagePath,
                            )))),
                size20,
                // page title
                Container(
                  height: 135,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        customText(
                            fontSize: 16,
                            text: tutorialController!.tutorials![tutorialController!.tutorialIndex].pageTitle.tr,
                            textAlign: TextAlign.center,
                            fontColor: Color(0xff3BCCE1),
                            fontWeight: FontWeight.bold),
                        size10,
                        // text
                        Container(
                          width: 299.w,
                          child: customText(
                              fontSize: 14,
                              textAlign: TextAlign.center,
                              height: 1.5.h,
                              text: tutorialController!.tutorials![tutorialController!.tutorialIndex].tutorialText.tr),
                        ),
                      ],
                    ),
                  ),
                ),

                size20,
                // two buttons row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    tutorialController!.tutorialIndex == 0
                        ? SizedBox(
                            width: 141.w,
                          )
                        : customButton(
                            text: 'PREV'.tr,
                            onTapFunction: tutorialController!.previousTutorial,
                            width: 141,
                            height: 47,
                            textSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            borderColor: Colors.black,
                            textColor: Colors.black),
                    customButton(
                        onTapFunction: tutorialController!.nextTutorial,
                        text: tutorialController!.tutorialIndex == tutorialController!.tutorials!.length - 1
                            ? 'OK'.tr
                            : 'NEXT'.tr,
                        width: 141,
                        height: 47,
                        textSize: 16,
                        fontWeight: FontWeight.bold)
                  ],
                ),
              ],
            ),
    );
  }
}
