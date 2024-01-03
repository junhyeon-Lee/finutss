import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/modules/live%20user/controller/live_user_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/app_string.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:finutss/new%20ui/widget/live_user_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'follow_user_bottom_sheet.dart';

Future<void> liveUserBottomSheet(BuildContext context, {String? title, String? icon, bool? isSearchEnable}) {
  final LiveUserController liveUserController = Get.find();

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
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            CloseButtonCustom(
              onTap: () {
                Get.back();
              },
              topMargin: 50.h,
            ),
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
                height: MediaQuery.of(context).size.height * 0.92,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20.0.h, bottom: 2.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  (title ?? '').tr,
                                  style: TextStyle(
                                    color: AppColor.blueTextColor,
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                /* Text(
                                    " (22/33)",
                                    style: TextStyle(
                                      color: AppColor.subtitleColor.withOpacity(0.7),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),*/
                              ],
                            ),
                            SizedBox(
                              height: 36.h,
                            ),
                            (isSearchEnable ?? false)
                                ? Container(
                                    height: 39.h,
                                    margin: EdgeInsets.only(bottom: 10.h),
                                    decoration: BoxDecoration(
                                      color: AppColor.whiteColor,
                                      borderRadius: BorderRadius.circular(6.w),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColor.cardGradiant1.withOpacity(0.06),
                                          spreadRadius: 4,
                                          blurRadius: 4,
                                          offset: Offset(1, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15.w,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            style: TextStyle(
                                              color: AppColor.subTitleColor,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            controller: liveUserController.searchController,
                                            onChanged: (val) {
                                              liveUserController.searchUser(val);
                                            },
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.zero,
                                              isDense: true,
                                              border: InputBorder.none,
                                              hintText: "SEARCH_FRIEND".tr + "...",
                                              hintStyle: TextStyle(
                                                color: AppColor.subTitleColor.withOpacity(0.45),
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Obx(
                                          () {
                                            return !liveUserController.isSearchEnable.value
                                                ? Row(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.symmetric(
                                                          horizontal: 10.w,
                                                        ),
                                                        width: 1.w,
                                                        height: 16.h,
                                                        color: AppColor.tagLineBg,
                                                      ),
                                                      Image.asset(
                                                        IconAssets.search,
                                                        width: 20.w,
                                                      ),
                                                    ],
                                                  )
                                                : InkWell(
                                                    onTap: () {
                                                      liveUserController.searchController.text = '';
                                                      liveUserController.searchUser('');
                                                      Navigation.closeKeyword();
                                                    },
                                                    child: CircleAvatar(
                                                      radius: 12,
                                                      backgroundColor: AppColor.CloseColor,
                                                      child: Icon(
                                                        Icons.close,
                                                        size: 12.w,
                                                        color: AppColor.backIconColor,
                                                      ),
                                                    ),
                                                  );
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Obx(() => liveUserController.liveUserList.length == 0
                            ? CustomVIew.errorMessageShow(liveUserController.isSearchEnable.value ? 'NO_SEARCH_RESULTS_FOUND'.tr : AppString.noLiveUserFound)
                            : ListView.builder(
                                itemCount: liveUserController.liveUserList.length,
                                itemBuilder: (context, index) {
                                  return Obx(() => LiveUserProfileWidget(
                                        userId: liveUserController.liveUserList[index].user?.id ?? '',
                                        currentUserId: liveUserController.userId ?? '',
                                        userName: liveUserController.liveUserList[index].user?.username ?? '',
                                        userProfile: liveUserController.liveUserList[index].user?.profilePhoto ?? '',
                                        userDis: liveUserController.liveUserList[index].user?.description ?? '',
                                        isFollowing: liveUserController.liveUserList[index].user?.isFollowing ?? false,
                                        onTap: () {
                                          if(liveUserController.liveUserList[index].user?.id!=liveUserController.userId){
                                            Navigator.of(context).push(
                                              PageRouteBuilder(
                                                opaque: false,
                                                pageBuilder: (BuildContext context, _, __) => FollowBottomSheet(
                                                  userId: liveUserController.liveUserList[index].user?.id ?? '',
                                                  index: index,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        onTapUserIcon: () {
                                          if (liveUserController.liveUserList[index].user?.isFollowing ?? false) {
                                            liveUserController.unFollow(
                                                userId: liveUserController.liveUserList[index].user?.id ?? '',
                                                index: index,
                                                type: Constants.isLiveUser);
                                          } else {
                                            liveUserController.follow(
                                                userId: liveUserController.liveUserList[index].user?.id ?? '',
                                                index: index,
                                                type: Constants.isLiveUser);
                                          }
                                        },
                                      ));
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
