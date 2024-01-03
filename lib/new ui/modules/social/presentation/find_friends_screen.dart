import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/social/controller/social_controller.dart';
import 'package:finutss/new%20ui/modules/user_profile/presentation/user_profile_screen.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FindFriendsScreen extends StatelessWidget {
  FindFriendsScreen({Key? key}) : super(key: key);

  final SocialController controller = Get.find();



  @override
  Widget build(BuildContext context) {
    controller.findController.text = '';
    controller.isSearchEnable.value = false;
    controller.keyboardIsVisible(context);
    controller.scrollController.addListener(controller.pagination);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            CustomSettingRow(
              title: "FIND_FRIENDS".tr.toUpperCase(),
              horizontalPadding: 22.w,
              fontWeight: FontWeight.w700,
              fontsize: 18.sp,
            ),
            SizedBox(
              height: 11.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchView(),
                  SizedBox(
                    height: 14.h,
                  ),
                 Obx(() => !controller.isSearchEnable.value
                     ? Text(
                   "SEARCH_INFO".tr,
                   style: TextStyle(
                     color: AppColor.subTitleColor.withOpacity(0.7),
                     fontSize: 13.sp,
                     fontWeight: FontWeight.w500,
                     height: 1.7,
                     letterSpacing: 0.2,
                   ),
                 )
                     : SizedBox())
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            //tagView(),

            Expanded(
              child: Obx(() {
                return controller.isSearchEnable.value
                    ? searchUserList()
                    : controller.recommendedUsers.length==0 ? SizedBox() : recommendedView();
              }),
            )
          ],
        ),
      ),
    );
  }




  Widget tagView(){
    return   SizedBox(
              height: 28.h,
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return Obx(() {
                    return GestureDetector(
                      onTap: () {
                        controller.selectTagIndex.value = i;
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 13.w),
                        decoration: BoxDecoration(
                            color: controller.selectTagIndex.value == i
                                ? AppColor.tagSelectBg
                                : Colors.transparent,
                            border: Border.all(
                              width: 1,
                              color: controller.selectTagIndex.value == i
                                  ? AppColor.blue
                                  : AppColor.tagLineBg,
                            ),
                            borderRadius: BorderRadius.circular(6.w)),
                        child: Center(
                          child: Text(
                            controller.tagList[i].toString(),
                            style: controller.selectTagIndex.value == i
                                ? TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10.sp,
                                    color: AppColor.blue,
                                  )
                                : TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11.sp,
                                    color: AppColor.declineBg,
                                    letterSpacing: 0.3,
                                  ),
                          ),
                        ),
                      ),
                    );
                  });
                },
                separatorBuilder: (context, i) {
                  return SizedBox(
                    width: 13.w,
                  );
                },
                itemCount: controller.tagList.length,
              ),
            );
  }

  Widget searchView(){
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(6.w),
        boxShadow: [
          BoxShadow(
            color: AppColor.cardGradiant1.withOpacity(0.06),
            spreadRadius: 14,
            blurRadius: 12,
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
              focusNode: controller.searchFocus,
              style: TextStyle(
                color: AppColor.subTitleColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
              controller: controller.findController,
              onChanged: (val) {
                controller.searchFriend(val);
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
              return !controller.isSearchEnable.value
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
                  controller.findController.text = '';
                  controller.isSearchEnable.value = false;
                  Navigation.closeKeyword();
                  controller.userList.value=[];
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
    );
  }


  Widget recommendedView(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(
            height: 29.5.h,
          ),
          Text(
            "RECOMMENDED".tr,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColor.subTitleColor,
              letterSpacing: 0.4,
            ),
          ),

          SizedBox(height: 12.h,),

          Expanded(child: Obx(()=>ListView.separated(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 20.h),
              itemBuilder: (context, i) {
                return CustomVIew.userItemView(
                    onTap: (){
                      Get.to(UserProfileScreen(userId: controller.recommendedUsers[i].id,type: Constants.recommendedUser,index: i,),  transition: Routes.defaultTransition);
                    },
                    username: controller.recommendedUsers[i].username,
                    des: controller.recommendedUsers[i].description,
                    profilePhoto: controller.recommendedUsers[i].profilePhoto,
                    onTapUser: (){
                      controller.FollowApi(
                          i,
                          controller
                              .recommendedUsers[i].id ??
                              '');
                    }
                );
              },
              separatorBuilder: (context, i) {
                return SizedBox(
                  height: 10.h,
                );
              },
              itemCount: controller.recommendedUsers.value.length
          ))),

        ],
      ),
    );
  }



  Widget searchUserList(){
    return Obx(() => controller.isFirstTimeSearch.value ? Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: CustomVIew.shimmerUserListView(),
    )
        : controller.userList.length == 0
        ? SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 24.h),
          SvgPicture.asset(ImageAssets.noResultFound),
          SizedBox(height: 40.h),
          Text(
            "NO_SEARCH_RESULTS_FOUND".tr,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: AppColor.subTitleColor.withOpacity(0.7),
              letterSpacing: 0.2,
            ),
          )
        ],
      ),
    ) : Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 14.h,
          ),
          Expanded(
            child: Obx(() {
              return ListView.separated(
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 20.h),
                  itemBuilder: (context, i) {
                    return Obx(() => CustomVIew.userItemView(
                        onTap: (){
                          Get.to(UserProfileScreen(userId: controller.userList[i].id,index: i,type: Constants.isSearchUserScreen,),  transition: Routes.defaultTransition);
                        },
                        onTapUser: (){
                          if(controller.userList[i].isFollowing ?? false){
                            controller.unFollow(userId: controller.userList[i].id ?? '',index: i,screenCode: Constants.isSearchUserScreen);
                          }else{
                            controller.follow(userId: controller.userList[i].id ?? '',index: i,screenCode: Constants.isSearchUserScreen);
                          }
                        },
                        username: controller.userList[i].username.toString(),
                        des: (controller.userList[i].description ?? '').toString(),
                        profilePhoto: controller.userList[i].profilePhoto,
                        isFollowing: (controller.userList[i].isFollowing ?? false)
                    ));
                  },
                  separatorBuilder: (context, i) {
                    return SizedBox(
                      height: 10.h,
                    );
                  },
                  itemCount: controller.userList.value.length);
            }),
          ),
          Obx(() => controller.isLoadRunning.value
              ? Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
              : SizedBox()),
        ],
      ),
    ));
  }



}
