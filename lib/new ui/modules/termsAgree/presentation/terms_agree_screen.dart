import 'package:finutss/helper/toast_helper.dart';
import 'package:finutss/new%20ui/modules/privacy_policy_terms_condition/presentation/Receive_Marketing_Info_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/privacy_policy_terms_condition/presentation/privacy_policy_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/privacy_policy_terms_condition/presentation/terms_service_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/termsAgree/controller/terms_condition_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_auth_screen.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TermsAgreeScreen extends StatelessWidget {
  TermsAgreeScreen({Key? key}) : super(key: key);

  final TermsConditionController controller =
      Get.put(TermsConditionController());

  @override
  Widget build(BuildContext context) {
    return CustomAuthScreen(
      top: 100.h,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.h,
              ),
              Text(
                "AGREE".tr,
                style: TextStyle(
                    color: AppColor.subTitleColor,
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "READ_THIS_CONDITION_AND_CHECK_IT".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.5,
                    color: AppColor.subTitleColor.withOpacity(0.5),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 76.h,
              ),
              conditionListView(),
              SizedBox(
                height: 70.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: CustomSliderButton(
                  title: "SIGN_UP".tr.toUpperCase(),
                  onTap: () {
                    if (controller.conditionList[1].isSelect &&
                        controller.conditionList[2].isSelect &&
                        controller.conditionList[3].isSelect) {
                      Navigation.pushNamed(Routes.signUp);
                    } else {
                      AppToast.toastMessage(
                          'Please Accept Terms and Conditions.');
                    }
                  },
                  isCancelButton: false,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget conditionListView() {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        return Obx(() {
          return InkWell(
            onTap: () {
              if (i == 0) {
                controller.conditionList[0].isSelect =
                !controller.conditionList[0].isSelect;
                for (int a = 1; a < controller.conditionList.length; a++) {
                  if (controller.conditionList[0].isSelect) {
                    controller.conditionList[a].isSelect = true;
                  } else {
                    controller.conditionList[a].isSelect = false;
                  }
                }
              } else {
                if (i == 2 && !controller.conditionList[i].isSelect) {
                  termsConditionBottomSheet(context);
                }
                if (i == 3 && !controller.conditionList[i].isSelect) {
                  privacyPolicyBottomSheet(context);
                }
                if (i == 4 && !controller.conditionList[i].isSelect) {
                  ReceiveMarketingInfoBottomSheet(context);
                }

                controller.conditionList[0].isSelect = false;
                controller.conditionList[i].isSelect =
                !controller.conditionList[i].isSelect;
              }

              controller.conditionList.refresh();
            },
            child: Row(
              children: [
                Image.asset(
                  controller.conditionList[i].isSelect
                      ? IconAssets.checkBoxSelect
                      : IconAssets.checkBoxUnSelect,
                  width: 21.w,
                ),
                SizedBox(
                  width: 15.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              controller.conditionList[i].title,
                              maxLines: 2,
                              style: TextStyle(
                                  color: AppColor.alreadyTextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp),
                            ),
                          ),
                          controller.conditionList[i].isReqired
                              ? Text(
                            " *",
                            maxLines: 1,
                            style: TextStyle(
                                color: AppColor.orangeColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp),
                          )
                              : Container(),
                        ],
                      ),
                      controller.conditionList[i].des.isNotEmpty
                          ? Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Text(
                          controller.conditionList[i].des,
                          maxLines: 2,
                          style: TextStyle(
                            fontFamily: 'MontserratItalic',
                            color: AppColor.alreadyTextColor
                                .withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                            fontSize: 10.sp,
                          ),
                        ),
                      )
                          : SizedBox(),
                    ],
                  ),
                )
              ],
            ),
          );
        });
      },
      separatorBuilder: (context, i) {
        return SizedBox(
          height: 22.h,
        );
      },
      itemCount: controller.conditionList.length,
    );
  }
}
