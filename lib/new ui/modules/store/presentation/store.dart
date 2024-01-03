import 'package:finutss/new%20ui/in_app_purchase_service/app_purchase_service.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/home/widget/notification_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/store/controller/store_controller.dart';
import 'package:finutss/new%20ui/modules/store/widget/energy_point_view.dart';
import 'package:finutss/new%20ui/modules/store/widget/store_tab_bar.dart';
import 'package:finutss/new%20ui/modules/store/widget/subscription_view.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/notice_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class StoreScreen extends StatefulWidget {
  StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final StoreController controller = Get.put(StoreController());
  int initIndex = 0;

  @override
  void initState() {
    super.initState();

    initIndex = int.parse(Get.arguments['initIndex']);
    controller.callService();
  }

  @override
  void dispose() {
    PaymentService().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      "STORE_SUBSCRIPTION": [
        SubscriptionView(),
      ],
      "STORE_ENERGY_POINT": [
        EnergyPointView(),
      ],
    };

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColor.whiteColor,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.backGroundColor,
          body: Column(
            children: [
              Container(
                color: AppColor.whiteColor,
                child: CustomSettingRow(
                  height: 46.h,
                  title: "STORE".tr,
                  horizontalPadding: 22.w,
                  fontsize: 18.sp,
                  fontWeight: FontWeight.w700,
                  lastImagePath: IconAssets.notification,
                  child: GestureDetector(
                    onTap: () async {
                      Constants.isGuest == true
                          ? GuestNotice(context)
                          : Navigator.of(context).push(
                              PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context, _, __) => NotificationScreen(),
                              ),
                            );
                    },
                    child: Image.asset(
                      IconAssets.notification,
                      width: 23.w,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: StoreTabBar(
                  initialScrollIndex: initIndex,
                  tabBuilder: (BuildContext context, int index, bool active) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (index == 0) ...[
                              Stack(
                                children: [
                                  SvgPicture.asset(
                                    IconAssets.subscriptionIcon,
                                    width: 26.w,
                                  ),
                                  !active
                                      ? Container(
                                          width: 26.w,
                                          height: 26.w,
                                          color: AppColor.whiteColor.withOpacity(0.50),
                                        )
                                      : SizedBox()
                                ],
                              ),
                            ] else if (index == 1) ...[
                              Stack(
                                children: [
                                  SvgPicture.asset(
                                    IconAssets.energyPointIcon,
                                    width: 26.w,
                                  ),
                                  index == 1 && !active
                                      ? Container(
                                          width: 26.w,
                                          height: 26.w,
                                          color: AppColor.whiteColor.withOpacity(0.50),
                                        )
                                      : SizedBox()
                                ],
                              ),
                            ],
                            SizedBox(
                              width: 7.w,
                            ),
                            Text(
                              data.keys.elementAt(index).tr,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13.sp,
                                color: active ? AppColor.subTitleColor : AppColor.subTitleColor.withOpacity(0.3),
                              ),
                            ),
                          ],
                        ),
                      ),
                      !active
                          ? SizedBox()
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1.2.h,
                              decoration: BoxDecoration(
                                color: AppColor.orangeColor,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.w),
                                  topLeft: Radius.circular(10.w),
                                ),
                              ),
                            ),
                    ],
                  ),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        children: [
                          ...data.values
                                  .elementAt(index)
                                  .asMap()
                                  .map(
                                    (index, value) => MapEntry(
                                      index,
                                      value,
                                    ),
                                  )
                                  .values ??
                              ""
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
