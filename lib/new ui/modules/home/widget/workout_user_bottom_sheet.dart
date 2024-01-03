import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/modules/home/controller/home_screen_controller.dart';
import 'package:finutss/new%20ui/modules/user_profile/presentation/user_profile_screen.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Future<void> workoutUserBottomSheet(BuildContext context,
    {String? title, String? icon}) {
  final HomeScreenController controller = Get.find();

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

            CloseButtonCustom(onTap: (){Navigation.pop();}),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(
                      MediaQuery.of(context).size.width,
                      100.0,
                    ),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                  EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      HeaderWidget(
                        icon: icon,
                        title: title,
                      ),
                      Expanded(
                        child: Obx(() => ListView.builder(
                          itemCount: controller.workoutUserList.length,
                          itemBuilder: (context, index) {

                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => UserProfileScreen(
                                      userId: controller
                                          .workoutUserList[index].id  ?? '',
                                      index: index,
                                      type: Constants.workoutUser,
                                    )));
                              },
                              child: Padding(
                                padding:
                                EdgeInsets.symmetric(vertical: 4.5.h),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(9.w),
                                    color: AppColor.whiteColor[100],
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10.7,
                                  ),
                                  margin: EdgeInsets.only(bottom: 1.4),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            CustomCircleImageview(
                                              width: 55.w,
                                              imagePath: controller
                                                  .workoutUserList[
                                              index]
                                                  .profilePhoto ??
                                                  '',
                                            ),
                                            SizedBox(width: 16.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Text(
                                                    controller
                                                        .workoutUserList[
                                                    index]
                                                        .username ??
                                                        '',
                                                    style: TextStyle(
                                                      color: AppColor
                                                          .subTitleColor,
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 7.h,
                                                  ),
                                                  Text(
                                                    controller
                                                        .workoutUserList[
                                                    index]
                                                        .description ??
                                                        '',
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                        color: AppColor
                                                            .subTitleColor
                                                            .withOpacity(
                                                            0.8),
                                                        height: 1.5),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          bool isFollow = controller.workoutUserList[index].isFollowing ?? false;
                                          if (isFollow) {
                                            controller.unFollowWorkout(userId: controller.workoutUserList[index].id ?? '', index: index);
                                          } else {
                                            controller.follow(userId: controller.workoutUserList[index].id ?? '', index: index);
                                          }
                                        },
                                        child: SizedBox(
                                          height: 30.w,
                                          width: 70.w,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: SvgPicture.asset(
                                              (controller
                                                  .workoutUserList[
                                              index]
                                                  .isFollowing ??
                                                  false)
                                                  ? IconAssets
                                                  .addUserRightGray
                                                  : IconAssets.addUser,
                                              width: 17.w,
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 5.w,)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                      )
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

class HeaderWidget extends StatelessWidget {
  final String? icon;
  final String? title;

  HeaderWidget({this.icon, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 14.0.h),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              title?.tr.toUpperCase() ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.subTitleColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 26.h,
          ),
        ],
      ),
    );
  }
}
