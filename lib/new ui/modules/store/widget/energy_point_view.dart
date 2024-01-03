import 'dart:io';

import 'package:finutss/new%20ui/in_app_purchase_service/app_purchase_service.dart';
import 'package:finutss/new%20ui/modules/store/controller/store_controller.dart';
import 'package:finutss/new%20ui/modules/store/widget/corner_banner.dart';
import 'package:finutss/new%20ui/modules/store/widget/title_description.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/log_utils.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class EnergyPointView extends StatelessWidget {
  EnergyPointView({Key? key}) : super(key: key);

  final StoreController controller = Get.find<StoreController>();
  int incriment=0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleDescription(
          title: 'STORE_ENERGY_POINT',
          description: 'STORE_IF_YOU_CHARGE_THE_EP_AND_PURCHASE_THE_TRACK_YOU_CAN_USE_THE_PURCHASED_TRACK_UNLIMITEDLY_FOR_24_HOURS',
        ),
        Obx(() => ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 14.h),
            itemBuilder: (context, i) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(18.w)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 17.h),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 5.h),
                          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
                          decoration: BoxDecoration(
                              color: AppColor.energyCardBg,
                              borderRadius: BorderRadius.all(Radius.circular(12.w)),
                              border: Border.all(width: 1.w, color: AppColor.energyBorderColor)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 36.w,
                                height: 36.w,
                                margin: EdgeInsets.only(right: 12.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8.w)),
                                  color: AppColor.energyIconBg,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(IconAssets.energyPointIcon,width: 20.w,),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      controller.energyList[i].title.tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.sp,
                                        letterSpacing: 0.2,
                                        color: AppColor.subTitleColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.2.h,
                                    ),
                                    Text(
                                      controller.energyList[i].description.tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 9.sp,
                                        color: AppColor.subTitleColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.3.h,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          controller.energyList[i].bonus + ' + '+'STORE_BONUS'.tr,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11.sp,
                                            color: AppColor.subTitleColor,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 4.w),
                                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                                          decoration: BoxDecoration(
                                            color: AppColor.orangeColor,
                                            borderRadius: BorderRadius.all(Radius.circular(50)),
                                          ),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                IconAssets.flashIcon,
                                                width: 9.w,
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Text(
                                                controller.energyList[i].flashPoint,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 10.sp,
                                                  color: AppColor.whiteColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                controller.energyList[i].amount,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 21.sp,
                                  letterSpacing: 0.2,
                                  color: AppColor.purple,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomSliderButton(
                          height: 48.w,
                          title: "₩ " + controller.energyList[i].point,
                          onTap: () {
                            LogUtils.logMSG('--AppPurchase-----user buy product id------->${controller.energyList[i].purchaseId}', StackTrace.empty);
                            PaymentService().buyProduct(controller.energyList[i].purchaseId);
                          },
                          isCancelButton: false,
                        )
                      ],
                    ),
                  ),
                 controller.energyList[i].isHotDeal ?  CornerBanner(
                    bannerPosition: CornerBannerPosition.topLeft,
                    bannerColor: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.h),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Transform.rotate(
                              angle: 90 * math.pi / 360,
                              child: Image.asset(
                                IconAssets.hotIcon,
                                height: 15.h,
                              )),
                          Text(
                            'HOT_DEAL'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 9.sp,
                              letterSpacing: 0.2,
                              color: AppColor.blueTextColor[200],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ) : SizedBox(),
                ],
              );
            },
            separatorBuilder: (context, i) {
              return SizedBox(
                height: 13.h,
              );
            },
            itemCount: controller.energyList.length)),
        SizedBox(
          height: 8.h,
        ),
        Container(
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16.w)),
                    border: Border.all(
                      width: 1.w,
                      color: AppColor.CloseColor,
                    ),
                    color: AppColor.backGroundColor),
                margin: EdgeInsets.only(top: 12.5.h),
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 18.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    if(Platform.isAndroid)...[
                      infoText(
                        isPadding: true,
                          text:
                          'STORE_EPS_PURCHASED_THROUGH_GOOGLE_PLAY_CAN_BE_REFUNDED_ACCORDING_TO_GOOGLES_REFUND_POLICY_AND_YOU_CAN_APPLY_FOR_A_REFUND_THROUGH_THE_GOOGLE_PLAY_CUSTOMER_CENTER'),
                      infoText(
                          isPadding: true,
                          text: 'STORE_EPS_THAT_HAVE_ALREADY_BEEN_USED_CANNOT_BE_REFUNDED'),
                      infoText(
                          isPadding: true,
                          text: 'STORE_GOOGLE_PLAY_CUSTOMER_CENTER_REFUND_REQUEST_SHORTCUT', isIcon: true)
                    ]else if(Platform.isIOS)...[
                      infoText(text: 'STORE_CASH_ITEMS_PURCHASED_FROM_IOS_APPS_CANNOT_RE_REFUNDED_IN_FINUTSS_ACCORDING_TO_APPLES_REFUND_POLICY_AND_ARE_ONLY_AVAILABLE_THROUGH_THE_APPLE_CUSTOMER_CENTER', isIcon: true),
                      infoText(text: 'STORE_PLEASE_REQUEST_A_REFUND_BY_CHOOSING_SETTINGS_ACCOUNT_VIEW_PURCHASE_HISTORY'),
                      infoText(text: 'STORE_ALTERNATIVELY_YOU_CAN_CHECK_THE_PAYMENT_DETAILS_AND_CONTACT_THE_APPLE_CUSTOMER_CENTER_TO_REQUEST_CANCELLATION_OF_THE_PAYMENT'),
                    ],

                    SizedBox(
                      height: 10.h,
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: AppColor.whiteColor,
                ),
                margin: EdgeInsets.only(left: 30.w),
                padding: EdgeInsets.symmetric(vertical: 6.3.h, horizontal: 16.w),
                child: Text(
                  'STORE_ADDITIONAL_INFO'.tr,
                  style: TextStyle(
                    color: AppColor.subTitleColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 14.h,
        ),
      ],
    );
  }

  Widget infoText({required String text, bool? isIcon,bool? isPadding}) {
    return Padding(
      padding: EdgeInsets.only(bottom : (isPadding ?? false) ? 10.h  : 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (isIcon ?? false)
              ? Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Transform.rotate(
                      angle: 180 * math.pi / 360,
                      child: SvgPicture.asset(
                        IconAssets.upArrow,
                        color: AppColor.blue,
                        height: 6.w,
                      )),
                )
              : Text(
                  '•  ',
                  style: TextStyle(
                    color: AppColor.subTitleColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
          Expanded(
            child: Text(
              text.tr,
              style: TextStyle(
                color: (isIcon ?? false) ? AppColor.blue : AppColor.subTitleColor,
                fontSize: 10.sp,
                fontWeight: (isIcon ?? false) ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
