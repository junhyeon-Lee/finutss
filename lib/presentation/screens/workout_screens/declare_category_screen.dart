import 'package:finutss/domain/controller/declare_report_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/app_bar.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:finutss/presentation/widgets/common_widgets/notification_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeclareCategoryScreen extends StatelessWidget {
  final DeclareReportController declareReportController = Get.put(DeclareReportController());

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    declareReportController.userInfo = Get.arguments;
    return Scaffold(
      /* --------------------------------- appbar --------------------------------- */
      backgroundColor: colorBackgroundSilver,
      key: scaffoldKey,
      endDrawer: ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), topLeft: Radius.circular(15)),
        child: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: Drawer(
            child: NotificationDrawer(),
          ),
        ),
      ),
      appBar: appbar(
        key: scaffoldKey,
        automaticallyImplyLeading: true,
        centerTitle: false,
        titleWidget: headingWidget(
          title: 'REPORT'.tr,
        ),
      ) as PreferredSizeWidget?,
      body: GetBuilder<DeclareReportController>(builder: (declareCategoryController) {
        return SingleChildScrollView(
          child: Column(
            children: [
              size15,
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      size15,
                      Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: customText(
                          text: 'WHY_DID_YOU_REPORT_IT'.tr,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      /* ------------------------------- categories ------------------------------- */
                      size35,
                      _categoryTile(
                        text: 'A_VIOLENT_THREAT'.tr,
                        onSelectedFunction: () {
                          declareReportController.onViolentThreatsPressed();
                        },
                        isSelected: declareCategoryController.isViolentThreats,
                      ),
                      size25,
                      _categoryTile(
                        text: 'TEASING_OR_HARASSMENT'.tr,
                        onSelectedFunction: () {
                          declareReportController.onHarassmentPressed();
                        },
                        isSelected: declareCategoryController.isHarassment,
                      ),
                      size25,
                      _categoryTile(
                        text: "THE_ACT_OF_STEALING_ONE'_NAMES".tr,
                        onSelectedFunction: () {
                          declareReportController.onIdentityPressed();
                        },
                        isSelected: declareCategoryController.isIdentityThief,
                      ),
                      size25,
                      _categoryTile(
                        text: 'SPAM_AND_FRAUD'.tr,
                        onSelectedFunction: () {
                          declareReportController.onSpamPressed();
                        },
                        isSelected: declareCategoryController.isSpam,
                      ),
                      size25,
                      _categoryTile(
                        text: 'PRIVACY_INFRINGEMENT'.tr,
                        onSelectedFunction: () {
                          declareReportController.onPrivacyPressed();
                        },
                        isSelected: declareCategoryController.isPrivacyInfringement,
                      ),
                      size25,
                      _categoryTile(
                        text: 'NOT_APPLICABLE'.tr,
                        isDivider: false,
                        onSelectedFunction: () {
                          declareReportController.onNotApplicablePressed();
                        },
                        isSelected: declareCategoryController.isNotApplicable,
                      ),
                      size15,
                    ],
                  ),
                ),
              ),
              /* --------------------------------- button --------------------------------- */
              size30,
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: customButton(
                          text: 'NEXT'.tr,
                          textSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 48,
                          onTapFunction: () {
                            declareReportController.onDeclareCategoryButtonPressed();
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  /* ------------------------------ local widget ------------------------------ */
  _categoryTile({String text = '', bool isDivider = true, bool isSelected = false, onSelectedFunction}) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: onSelectedFunction,
                child: Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                  size: 18.h,
                  color: colorDarkGrey,
                ),
              ),
              size10,
              customText(
                text: text,
                fontColor: colorWhitish,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          size10,
          isDivider
              ? Padding(
                  padding: EdgeInsets.only(left: 28.w, right: 23.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: colorWhitish,
                          thickness: 0.6,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
