import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/faq_menu.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/modules/social/controller/social_controller.dart';
import 'package:finutss/new%20ui/modules/social/presentation/follower_user_view_screen.dart';
import 'package:finutss/new%20ui/modules/social/presentation/following_user_view_screen.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:finutss/new%20ui/widget/custom_login_button.dart';
import 'package:finutss/presentation/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserProfileCard extends StatelessWidget {
  final String? UserProfile;
  final String? UserName;
  final String? UserBio;
  final String? UserFollower;
  final String? UserFollowing;
  final String? followTitle;
  bool BottomRow = false;
  bool button = false;
  bool isSocialScreen = false;
  bool? showExerciseMenu = false;
  final double? height;
  final VoidCallback? profileOnTap;
  final VoidCallback? moreOnTap;
  final Widget? child;
  RxInt selectedIndex = 0.obs;
  LoginModel? userModel;
  String? date;
  String? isSelectType;
  ValueChanged<String?>? valueChangedHandler;
  DateFormat dateFormat = DateFormat("MMMM dd, hh:mm aa");
  DateFormat dateFormatKo = DateFormat("MMMM dd, hh:mm",'ko');
  bool? isCurrentUser;
  final SocialController controller = Get.put(SocialController());
  List<FaqMenu> menuList = [
    FaqMenu('ALL', 'ALL'),
    FaqMenu('RIDE', 'WORKOUT_TYPE_RIDE'),
    FaqMenu('RUN', 'WORKOUT_TYPE_RUN'),
  ];

  UserProfileCard({
    Key? key,
    this.UserProfile,
    this.UserName,
    this.UserBio,
    this.UserFollower,
    this.UserFollowing,
    this.height,
    this.profileOnTap,
    required this.button,
    required this.BottomRow,
    required this.isSocialScreen,
    this.moreOnTap,
    this.followTitle,
    this.child,
    this.showExerciseMenu,
    this.valueChangedHandler,
    this.userModel,
    this.isCurrentUser,
    this.isSelectType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppSettingController settingController = Get.find();
    date = userModel?.data?.lastRecordUpdatedAt != null
        ?
    settingController.selectedLanguage.value == "한국어"?
    dateFormatKo.format(DateTime.parse(userModel?.data?.lastRecordUpdatedAt ?? DateTime.now().toString()).toLocal())
        :dateFormat.format(DateTime.parse(userModel?.data?.lastRecordUpdatedAt ?? DateTime.now().toString()).toLocal())
        : '';

    if(date!=null){
      date= Constants.removeAmPm(date ?? '');
    }


    if(isSelectType!=null){
      selectedIndex.value = menuList
          .indexWhere((note) {
        return note.title.toString().toLowerCase() ==
            isSelectType.toString().toLowerCase();
      });
    }


    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(
              14.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.07),
                blurRadius: 20.0,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 17.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isSocialScreen
                    ? Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              date ?? '',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColor.blueTextColor.withOpacity(0.5),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                        ],
                      )
                    : SizedBox(),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 11.h, horizontal: 10.w),
                  decoration: BoxDecoration(
                      color: AppColor.backGroundColor,
                      borderRadius: BorderRadius.circular(8.w)),
                  child: InkWell(
                    onTap: profileOnTap,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 4.w,
                        ),
                        SizedBox(
                          height: 54.w,
                          width: 54.w,
                          child: CustomCircleImageview(
                            width: 54.w,
                            imagePath: userModel?.data?.profilePhoto ?? '',
                          ),
                        ),
                        SizedBox(
                          width: 14.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userModel?.data?.username ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: AppColor.blueTextColor,
                                ),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              Text(
                                userModel?.data?.description ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp,
                                  color:
                                      AppColor.blueTextColor.withOpacity(0.8),
                                ),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: moreOnTap,
                          child: SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child:( isCurrentUser ?? false) ? Align(
                                alignment: Alignment.topRight,
                                child: Image.asset(IconAssets.more,scale: 4,)) : SvgPicture.asset(
                              IconAssets.sirenIcon,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.h,
                  ),
                  child: Row(
                    children: [
                      followRow(
                        IconAssets.follower,
                        Constants.numberCounter((userModel?.data?.followersCount ?? 0).toString()),
                        "FOLLOWER".tr,
                        () {
                          if(userModel?.data?.followersCount != 0){
                            Navigator.of(Get.context!).push(
                              PageRouteBuilder(
                                opaque: false,
                                pageBuilder:
                                    (BuildContext context, _,
                                    __) =>
                                    FollowerUserViewScreen(userID: userModel?.data?.id ?? ""),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      followRow(
                        IconAssets.following,
                        Constants.numberCounter((userModel?.data?.followingCount ?? 0).toString()),
                        "FOLLOWING".tr,
                        () {
                          if(userModel?.data?.followingCount != 0){
                            Navigator.of(Get.context!).push(
                              PageRouteBuilder(
                                opaque: false,
                                pageBuilder:
                                    (BuildContext context, _,
                                    __) =>
                                    FollowingUserViewScreen(isCurrentUser: isCurrentUser,userId: userModel?.data?.id ?? "",),
                              ),
                            );
                          }


                        },
                      ),
                    ],
                  ),
                ),
                showExerciseMenu!
                    ? Container(
                        height: 36.h,
                        margin: EdgeInsets.only(top: 10.h),
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              return Obx(() => Bouncing(
                                    duration: Duration(milliseconds: 100),
                                    onPressed: () {
                                      selectedIndex.value = i;
                                      valueChangedHandler!(menuList[i]
                                          .title
                                          .toString()
                                          .toLowerCase());
                                    },
                                    child: Container(
                                      width: 96.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(11.w),
                                        color: selectedIndex.value == i
                                            ? AppColor.orangeColor
                                            : Colors.transparent,
                                        border: Border.all(
                                          width: 1.2,
                                          color: selectedIndex.value == i
                                              ? AppColor.orangeColor
                                              : AppColor.cancelButtonBg,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          menuList[i].category.tr,
                                          style: TextStyle(
                                            color: selectedIndex.value == i
                                                ? AppColor.whiteColor
                                                : AppColor.cancelButtonColor,
                                            fontSize: 14.sp,
                                            fontWeight: selectedIndex.value == i
                                                ? FontWeight.w700
                                                : FontWeight.w600,
                                            letterSpacing: 0.4,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            },
                            separatorBuilder: (context, i) {
                              return SizedBox(
                                width: 10.w,
                              );
                            },
                            itemCount: menuList.length),
                      )
                    : SizedBox(),
                BottomRow
                    ? Column(
                        children: [
                          SizedBox(
                            height: 14.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              kmRow(
                                IconAssets.location,
                                isSelectType=='all' ? (userModel?.data?.totalDistanceInKm.toStringAsFixed(2) ?? '0') : isSelectType=='ride' ?
                                (userModel?.data?.totalRideDistanceInKm.toStringAsFixed(2) ?? '0') : (userModel?.data?.totalRunDistanceInKm.toStringAsFixed(2) ?? '0'),
                                "KM".tr,
                              ),
                              divider(),
                              kmRow(
                                IconAssets.time,
                                 getTotalSecond().toString(),
                                "MIN".tr,
                              ),
                              divider(),
                              kmRow(
                                IconAssets.km,
                                isSelectType=='all' ? (userModel?.data?.avgSpeedInKmPerHour.toStringAsFixed(2) ?? '0') : isSelectType=='ride' ? (userModel?.data?.avgRideSpeedInKmPerHour.toStringAsFixed(2) ?? '0') : (userModel?.data?.avgRunSpeedInKmPerHour.toStringAsFixed(2) ?? '0'),
                                "KMH".tr,
                              ),
                            ],
                          ),
                        ],
                      )
                    : SizedBox(),
                button
                    ? Padding(
                        padding: EdgeInsets.only(
                          right: 20.w,
                          left: 20.h,
                          top: 20.h,
                        ),
                        child: CustomLoginButton(
                          title: followTitle ?? "FOLLOW".tr.toUpperCase(),
                          isCancelButton: false,
                          onTap: () {},
                        ),
                      )
                    : SizedBox(
                        child: child,
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  
  
  dynamic getTotalSecond(){
    if(isSelectType=='all'){
      return (userModel?.data?.totalTimeInMin ?? 0);
    }else if(isSelectType=='ride'){
      return (userModel?.data?.totalRideTimeInMin ?? 0);
    }else{
      return (userModel?.data?.totalRunTimeInMin ?? 0);
    }
  }

  Widget divider() {
    return Container(
      height: 26.h,
      width: 1.w,
      color: AppColor.dividerColorKm,
    );
  }

  Widget followRow(String? imagePath, String? followerCount, String? title,
      VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath ?? IconAssets.follower,
              height: 35.h,
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              children: [
                Text(
                  followerCount ?? "0",
                  style: TextStyle(
                    color: AppColor.blueTextColor,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  title ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 11.sp,
                    color: AppColor.blueTextColor.withOpacity(
                      0.5,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget kmRow(String? ImagePath, String? km, String? kmString) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
          ),
          child: Image.asset(
            ImagePath ?? " ",
            height: 20.h,
          ),
        ),
        SizedBox(
          height: 7.h,
        ),
        Row(
          children: [
            Text(
              km ?? "",
              style: TextStyle(
                color: AppColor.blueTextColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              kmString ?? "",
              style: TextStyle(
                color: AppColor.blueTextColor.withOpacity(0.6),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
