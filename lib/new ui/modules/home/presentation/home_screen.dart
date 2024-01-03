import 'package:finutss/new%20ui/modules/connection/presentation/mobile_device_connection.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/riding_connection_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/running_connection_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/home/controller/home_screen_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeScreenController homeController = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.backGroundColor,
      ),
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 10.w, top: 42.h, right: 10.w),
            child: Column(
              children: [
                Text(
                  "EXERCISER".tr,
                  style: TextStyle(
                      color: AppColor.blueTextColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 21.sp),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 25.0.w, top: 14.h, right: 25.0.w),
                  child: Text(
                    'EXERCISER'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.subTitleColor.withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                      fontSize: 12.7.sp,
                      letterSpacing: 0.5,
                      height: 1.6,
                    ),
                  ),
                ),
                SizedBox(
                  height: 33.h,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 3.51,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 21,
                  ),
                  itemCount: Constants.exerciserList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        homeController.selectedIndex.value = index;
                        if (index == 0) {
                          RidingConnectionBottomSheet(context,
                              title: Constants.exerciserList[index].title,
                              icon:
                                  Constants.exerciserList[index].topPrefixIcon);
                        } else if (index == 1) {
                          RunningConnectionBottomSheet(
                            context,
                            title: Constants.exerciserList[1].title,
                            icon: Constants.exerciserList[1].topPrefixIcon,
                          );
                        } else if (index == 2) {
                          mobileDeviceConnectionBottomSheet(
                            context,
                            title: Constants.exerciserList[2].title,
                            icon: Constants.exerciserList[2].topPrefixIcon,
                          );
                        }
                      },
                      child: Obx(
                        () => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.9),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(11),
                              border: Border.all(
                                  width: 1.2,
                                  color: homeController.selectedIndex.value ==
                                          index
                                      ? AppColor.orangeColor
                                      : Colors.transparent),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColor.cardGradiant1.withOpacity(0.05),
                                  spreadRadius: 0.2,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0.w, right: 10.0.w, top: 8.h),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        Constants
                                            .exerciserList[index].topPrefixIcon,
                                        scale: 4,
                                      ),
                                      Image.asset(
                                        IconAssets.information,
                                        scale: 4,
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    Constants.exerciserList[index].mainIcon,
                                    scale: 5,
                                  ),
                                  SizedBox(
                                    height: index == 3 ? 28.h : 17.h,
                                  ),
                                  Text(
                                    Constants.exerciserList[index].title,
                                    style: TextStyle(
                                      color: AppColor.blueTextColor,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Text(
                                    Constants.exerciserList[index].description,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: AppColor.blueTextColor[100]
                                            ?.withOpacity(0.7),
                                        fontSize: 7.2.sp,
                                        height: 1.7),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
