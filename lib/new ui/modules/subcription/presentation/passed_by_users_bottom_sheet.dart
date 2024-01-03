import 'package:finutss/new%20ui/modules/subcription/controller/subscription_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> PassByUsersBottomSheet(
  BuildContext context,
  String? imagePath,
  String? Name,
  Color? color,
) {
  final SubSubscriptionController controller =
      Get.put(SubSubscriptionController());
  String previousDate = "";
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    enableDrag: false,
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.black.withOpacity(0.2),
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        height: MediaQuery.of(context).size.height * 2,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: 15.w,
                top: 70.h,
              ),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      IconAssets.close,
                      scale: 4,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(
                      MediaQuery.of(context).size.width,
                      74.0,
                    ),
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.92,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 7.w,
                    right: 10.w,
                    top: 10.h,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'USERS'.tr,
                        style: TextStyle(
                          color: AppColor.blueTextColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(
                              8.w,
                            ),
                          ),
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: controller.UserPassByList.length,
                            itemBuilder: (context, index) {
                              bool isShow = false;
                              String currentDate = controller
                                  .UserPassByList[index].date
                                  .toString();
                              if (previousDate != currentDate) {
                                previousDate = currentDate;
                                print("previousDate$previousDate");
                                isShow = true;
                              }
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 2.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    isShow
                                        ? Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10.h,
                                            ),
                                            child: Text(
                                              currentDate.tr,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: AppColor.blueTextColor,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 11.h, horizontal: 10.w),
                                      decoration: BoxDecoration(
                                          color: AppColor.backGroundColor,
                                          borderRadius:
                                              BorderRadius.circular(8.w)),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          SizedBox(
                                            height: 54.w,
                                            child: CircleAvatar(
                                              backgroundColor: controller
                                                  .UserPassByList[index].color,
                                              radius: 27.h,
                                              child: CircleAvatar(
                                                backgroundImage:
                                                    ExactAssetImage(
                                                  controller
                                                      .UserPassByList[index]
                                                      .image
                                                      .toString(),
                                                ),
                                                radius: 23.h,
                                                backgroundColor:
                                                    Colors.transparent,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 14.w,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  controller
                                                      .UserPassByList[index]
                                                      .name
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.sp,
                                                    color:
                                                        AppColor.blueTextColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 6.h,
                                                ),
                                                Text(
                                                  controller
                                                      .UserPassByList[index]
                                                      .subTitle
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11.sp,
                                                    color: AppColor
                                                        .blueTextColor
                                                        .withOpacity(0.8),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Image.asset(
                                            IconAssets.more,
                                            height: 9.h,
                                            width: 3.w,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
