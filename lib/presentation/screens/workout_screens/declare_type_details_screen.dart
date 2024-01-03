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

class DeclareTypeDetailsScreen extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final DeclareReportController declareReportController = Get.put(DeclareReportController());

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 14.h, right: 16.w),
              child:
                  customText(height: 1.5, text: 'DETAILED_REPORTING_CONTENT_QUESTIONS'.tr, fontWeight: FontWeight.w500),
            ),
            /* -------------------------------- textfield ------------------------------- */
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 14.h),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: declareReportController.declareTypeTextController,
                  maxLength: 60,
                  minLines: 10,
                  maxLines: 12,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintMaxLines: 100,
                    hintText: 'DETAILED_REPORTING_CONTENT_HINT'.tr,
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: colorWhitish,
                      fontWeight: FontWeight.w600,
                    ),
                    contentPadding: EdgeInsets.only(left: 15.w, top: 15.h, right: 15.w),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            size20,
            /* --------------------------------- button --------------------------------- */
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: customButton(
                        text: 'SEND'.tr,
                        textSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 48,
                        onTapFunction: () {
                          declareReportController.onDeclareTypeButtonPressed();
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
