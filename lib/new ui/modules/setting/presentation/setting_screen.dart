import 'package:clipboard/clipboard.dart';
import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/controller/black_list_controller.dart';
import 'package:finutss/new%20ui/modules/contact_us/controller/contact_us_controller.dart';
import 'package:finutss/new%20ui/modules/privacy_policy_terms_condition/presentation/privacy_policy_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/privacy_policy_terms_condition/presentation/terms_service_bottom_sheet.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:finutss/new%20ui/widget/finutss_store_card.dart';
import 'package:finutss/new%20ui/widget/notice_dialog.dart';
import 'package:finutss/presentation/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key, required this.scrollController}) : super(key: key);

  final ScrollController scrollController;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final BlackListController blackListController = Get.find();
  final AppSettingController controller = Get.find();
  final ContactUsController contactUsController = Get.put(ContactUsController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!Constants.isGuest) {
        controller.getWallet();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: SingleChildScrollView(
          controller: widget.scrollController,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 14.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                accountRow(),
                SizedBox(
                  height: 12.h,
                ),
                Constants.isGuest == true
                    ? Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 13.h,
                          horizontal: 10.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.settingCardBg,
                          borderRadius: BorderRadius.circular(
                            8.w,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                'AS_GUEST'.tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: AppColor.blueTextColor,
                                ),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              Text(
                                "GUEST_SERVICE_LOG_IN".tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11.sp,
                                  height: 1.2,
                                  color:
                                      AppColor.blueTextColor.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Obx(
                        () => profileCard(
                          onTap: () async {
                            Navigation.pushNamed(Routes.profileScreen);
                          },
                            isSubscription: controller.isSubscription.value,
                          userName: controller.logInUser.value.name,
                          profilePhoto:
                              controller.logInUser.value.profilePicture,
                          bio: controller.logInUser.value.bio,
                          energyPoint: (controller.walletModel.value.data?.energyPointWallet?.balance ?? 0).toString()
                        ),
                      ),
                SizedBox(
                  height: 5.h,
                ),
                 FinutssStoreCard(),
                SizedBox(
                  height: 12.h,
                ),
                settingCard(
                  title: 'MY_PAGE'.tr,
                  subTitle: "",
                  onTap: () async {
                    Constants.isGuest == true
                        ? GuestNotice(context)
                        : Navigation.pushNamed(Routes.myPageScreen);
                    controller.getLanguageCode();
                  },
                ),
                // settingCard(
                //   title: "SUBSCRIPTIONS".tr,
                //   subTitle: "PAY_STANDARD".tr,
                //   onTap: () async {
                //     Constants.isGuest == true
                //         ? GuestNotice(context)
                //         : Navigation.pushNamed(Routes.subscriptionInoScreen);
                //   },
                // ),
                Obx(() {
                  return settingCard(
                    title: 'BLACKLIST'.tr,
                    subTitle:
                        "${blackListController.blackListTotalLength.value.toString()}",
                    onTap: () async {
                      Constants.isGuest == true
                          ? GuestNotice(context)
                          : Navigation.pushNamed(Routes.blackListScreen);
                    },
                  );
                }),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 17.w,
                    vertical: 15.h,
                  ),
                  child: Text(
                    'APP_SETTING'.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17.sp,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                Obx(
                  () => settingCard(
                    title: 'LANGUAGE'.tr,
                    subTitle: controller.selectedLanguage.value,
                    onTap: () {
                      controller.getLanguageCode();
                      Navigation.pushNamed(Routes.languageScreen);
                    },
                  ),
                ),
                settingCard(
                  title: 'SOUND'.tr,
                  subTitle: '',
                  onTap: () {
                    Navigation.pushNamed(Routes.soundScreen);
                    },
                ),

                /// App Permission Card
                // settingCard(
                //   AppString.appPermission,
                //   '',
                //   () {
                //     Navigation.pushNamed(Routes.appPermissionsScreen);
                //   },
                // ),

                settingCard(
                  title: "PUSH_NOTIFICATIONS".tr,
                  subTitle: '',
                  onTap: () {
                    Navigation.pushNamed(Routes.pushNotificationScreen);
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 17.w,
                    vertical: 15.h,
                  ),
                  child: Text(
                    'CUSTOMER'.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17.sp,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                settingCard(
                  title: 'NOTICE'.tr,
                  subTitle: '',
                  onTap: () {
                    Constants.isGuest == true
                        ? GuestNotice(context)
                        : Navigation.pushNamed(Routes.noticeScreen);
                  },
                ),
                settingCard(
                  title: 'EVENTS'.tr,
                  subTitle: '',
                  onTap: () {
                    Constants.isGuest == true
                        ? GuestNotice(context)
                        : Navigation.pushNamed(Routes.eventScreen);
                  },
                ),
                settingCard(
                  title: 'USER_GUIDE'.tr,
                  subTitle: '',
                  onTap: () {
                    Navigation.pushNamed(
                      Routes.userGuideScreen,
                    );
                  },
                ),
                settingCard(
                  title: "FAQ".tr,
                  subTitle: '',
                  onTap: () {
                    Constants.isGuest == true
                        ? GuestNotice(context)
                        : Navigation.pushNamed(Routes.faqScreen);
                  },
                ),
                settingCard(
                  title: 'CONTACT_US'.tr,
                  subTitle: '',
                  onTap: () async {
                    Constants.isGuest == true
                        ? GuestNotice(context)
                        : Navigation.pushNamed(Routes.contactUsScreen);
                  },
                ),
                settingCard(
                  title: 'PRIVACY_POLICY'.tr,
                  subTitle: '',
                  onTap: () {
                    privacyPolicyBottomSheet(context);
                  },
                ),
                settingCard(
                  title: 'TERMS_OF_SERVICE'.tr,
                  subTitle: '',
                  onTap: () {
                    termsConditionBottomSheet(context);
                  },
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    SizedBox(width: 5.w),
                    Text(
                      'v.${controller.version.value}',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.blueTextColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      contactUsController.userModel.value.data?.uniqueId??'',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.blueTextColor,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    InkWell(
                      onTap: () {
                        FlutterClipboard.copy(contactUsController.userModel.value.data?.uniqueId??'').then(
                          (value) => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('COPY'.tr),
                            ),
                          ),
                        );
                      },
                      child: Image.asset(
                        IconAssets.copy,
                        height: 17.h,
                        width: 15.w,
                      ),
                    ),
                    SizedBox(width: 5.w)
                  ],
                ),
                SizedBox(
                  height: 100.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget  settingCard({String? title, String? subTitle, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 3.8.h,
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColor.cardGradiant1.withOpacity(0.02),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(
              6,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15.h,
              horizontal: 12.w,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  title ?? 'MY_PAGE'.tr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
                    color: AppColor.blueTextColor,
                  ),
                ),
                Spacer(),
                Text(
                  subTitle ?? "",
                  style: TextStyle(
                    color: AppColor.blueTextColor.withOpacity(0.6),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.2,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColor.iconColorBg,
                  size: 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileCard(
      {VoidCallback? onTap,
      String? userName,
      String? bio,
      bool? isSubscription,
      String? energyPoint,
      String? profilePhoto}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5.h,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: 13.h,
            horizontal: 10.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              8.w,
            ),
            color: AppColor.settingCardBg,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 4.w,
              ),
              CustomCircleImageview(
                width: 58.w,
                imagePath: profilePhoto ?? '',
              ),
              SizedBox(
                width: 14.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        (isSubscription ?? false) ? Row(
                          children: [
                            Image.asset(IconAssets.subscribedIcon,width: 17.w,),
                            SizedBox(width: 5.w,),
                          ],
                        ) : SizedBox(),

                        Expanded(
                          child: Text(
                            (userName ?? '').isEmpty ? 'AS_GUEST'.tr : (userName ?? ''),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: AppColor.blueTextColor,
                            ),
                          ),
                        ),

                        Row(
                          children: [
                            SvgPicture.asset(IconAssets.energyPointIcon,width: 22.w,),
                            SizedBox(width: 6.w,),
                            Text(
                              energyPoint ?? '0',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                                letterSpacing: 0.2,
                                color: AppColor.purple,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      bio ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11.sp,
                        color: AppColor.blueTextColor.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget accountRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ACCOUNT'.tr,
            style: TextStyle(
              color: AppColor.blueTextColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Bouncing(
            duration: Duration(milliseconds: 100),
            onPressed: () async {
              Constants.isGuest == true
                  ? Navigation.pushNamed(
                      Routes.signUp,
                    )
                  : controller.logout();
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 17.w,
                vertical: 6.h,
              ),
              decoration: BoxDecoration(
                color: AppColor.lightRedColor,
                borderRadius: BorderRadius.circular(
                  7,
                ),
              ),
              child: Constants.isGuest == true
                  ? Text(
                      "SIGN_UP".tr,
                      style: TextStyle(
                        color: AppColor.RedColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          IconAssets.logout,
                          scale: 3,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          'SIGN_OUT'.tr,
                          style: TextStyle(
                            color: AppColor.RedColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                          ),
                        )
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
