import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/profile/controller/edit_profile_controller.dart';
import 'package:finutss/new%20ui/modules/profile/presentation/fullScreen_image.dart';
import 'package:finutss/new%20ui/modules/profile/widget/change_image_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/profile/widget/edit_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/store/presentation/store.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final EditProfileController controller = Get.find<EditProfileController>();
  AppSettingController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getCurrentUser();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.backGroundColor,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.backGroundColor,
          body: Column(
            children: [
              CustomSettingRow(
                title: "PROFILE".tr.toUpperCase(),
                horizontalPadding: 22.w,
                fontsize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 17.h,
                      ),
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 22.w),
                            margin: EdgeInsets.only(top: 57.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(14.w), topLeft: Radius.circular(14.w)),
                              color: AppColor.whiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.cardGradiant1.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 57.w,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Obx(() => profileController.isSubscription.value
                                        ? Row(
                                            children: [
                                              Image.asset(
                                                IconAssets.subscribedIcon,
                                                width: 18.w,
                                              ),
                                              SizedBox(
                                                width: 6.w,
                                              ),
                                            ],
                                          )
                                        : SizedBox()),
                                    Obx(
                                      () => Text(
                                        controller.nickName.value,
                                        style: TextStyle(
                                          color: AppColor.chatTextColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(8.w)),
                                    color: AppColor.whiteColor[100],
                                  ),
                                  height: 72.h,
                                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                                  child: Obx(
                                    () => Center(
                                      child: Text(
                                        controller.bio.value,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: AppColor.subTitleColor.withOpacity(
                                              0.7,
                                            ),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13.sp,
                                            height: 1.6),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 18.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      iconMenu(
                                        image: IconAssets.camera,
                                        onTap: () {
                                          ChangeImageBottomSheet(context);
                                        },
                                        title: 'PHOTO'.tr,
                                      ),
                                      iconMenu(
                                        image: IconAssets.Edit,
                                        onTap: () {
                                          controller.nickNameController.text = controller.nickName.value;
                                          controller.bioController.text = controller.bio.value;
                                          EditBottomSheet(context);
                                          /*Navigator.of(context).push(
                                  PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder:
                                        (BuildContext context, _, __) =>
                                        EditBottomSheet(),
                                  ),
                              );*/
                                        },
                                        title: "EDIT".tr,
                                      ),
                                      iconMenu(
                                        image: IconAssets.myPage,
                                        onTap: () {
                                          Navigation.pushNamed(Routes.myPageScreen);
                                          //ChangeNoticeBottomSheet(context);
                                        },
                                        title: 'MY_PAGE'.tr,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (!controller.avatarPath.value.isEmpty) {
                                Get.to(
                                    FullScreenImage(
                                      url: null,
                                      type: Constants.typePhoto,
                                    ),
                                    transition: Routes.defaultTransition);
                              }
                            },
                            child: Obx(
                              () {
                                return Center(
                                  child: CustomCircleImageview(
                                    width: 110.w,
                                    imagePath: controller.avatarPath.value,
                                    boxFit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 15.w),
                        child: Column(
                          children: [
                            myEpStatus(),
                            SizedBox(
                              height: 14.h,
                            ),

                            Obx(() => profileController.transactionList.length==0 ? noSubscriptionView() : mySubscriptionStatus(),),
                           // Obx(() => mySubscriptionStatus(isGetSubscription: !profileController.isSubscription.value,daysRemaning: profileController.daysRemaining.value.toString())),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconMenu({String? image, VoidCallback? onTap, String? title}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: AppColor.cardGradiant1.withOpacity(0.1),
                  spreadRadius: 4,
                  blurRadius: 40,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.w),
              child: Image.asset(
                image ?? IconAssets.camera,
                height: 22.h,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            title!,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
              color: AppColor.subTitleColor.withOpacity(0.9),
            ),
          )
        ],
      ),
    );
  }

  Widget myEpStatus() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(10.w)),
        boxShadow: [
          BoxShadow(
            color: AppColor.cardGradiant1.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 20,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 17.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MY_EP_STATUS'.tr,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12.sp,
              letterSpacing: 0.4,
              color: AppColor.subTitleColor,
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 37.w,
                height: 37.w,
                margin: EdgeInsets.only(right: 12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.w)),
                  color: AppColor.energyIconBg,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    IconAssets.energyPointIcon,
                    width: 20.w,
                  ),
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
                      'STORE_ENERGY_POINT'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp,
                        letterSpacing: 0.2,
                        color: AppColor.subTitleColor,
                      ),
                    ),
                    SizedBox(
                      height: 1.6.h,
                    ),
                    Text(
                      'PURCHASE_A_TRACK_AS_AN_EP'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 8.sp,
                        color: AppColor.subTitleColor,
                      ),
                    ),
                    SizedBox(
                      height: 5.3.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 14.w,
              ),
              Text(
                (profileController.walletModel.value.data?.energyPointWallet?.balance ?? 0).toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 21.sp,
                  letterSpacing: 0.2,
                  color: AppColor.purple,
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
            ],
          ),
          SizedBox(
            height: 13.h,
          ),
          CustomSliderButton(
            height: 48.w,
            title: 'EARN_MORE_EP'.tr,
            onTap: () {
              //Get.to(StoreScreen(), transition: Transition.rightToLeft);
              Navigation.pushNamed(Routes.storeScreen,arg: {"initIndex": '1'});
            },
            isCancelButton: false,
          )
        ],
      ),
    );
  }

  Widget noSubscriptionView(){
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(10.w)),
        boxShadow: [
          BoxShadow(
            color: AppColor.cardGradiant1.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 20,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 17.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MY_SUBSCRIPTION_STATUS'.tr,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12.sp,
              letterSpacing: 0.4,
              color: AppColor.subTitleColor,
            ),
          ),
          SizedBox(
            height: 11.h,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(7)), color: AppColor.whiteColor[100]),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
            child:  Row(
              children: [
                Text(
                  'NO_SUBSCRIPTION_TAKEN_YET'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    letterSpacing: 0.2,
                    color: AppColor.subTitleColor.withOpacity(0.7),
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                SvgPicture.asset(IconAssets.sadEmojiIcon),
              ],
            ),
          ),
          SizedBox(
            height: 11.h,
          ),
          CustomSliderButton(
            height: 48.w,
            title: 'GET_SUBSCRIPTION'.tr,
            onTap: () {
               // Get.to(StoreScreen(), transition: Transition.rightToLeft);

              Navigation.pushNamed(Routes.storeScreen,arg: {"initIndex": '0'});
            },
            isCancelButton: false,
          )
        ],
      ),
    );
  }

  Widget mySubscriptionStatus() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(10.w)),
        boxShadow: [
          BoxShadow(
            color: AppColor.cardGradiant1.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 20,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 17.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MY_SUBSCRIPTION_STATUS'.tr,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12.sp,
              letterSpacing: 0.4,
              color: AppColor.subTitleColor,
            ),
          ),
          SizedBox(
            height: 11.h,
          ),
          Obx(() => ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,i){
                return subscriptionItemView(planId: profileController.transactionList[i].purchaseTransactionDetails?.subscriptionId,daysRemaining: Constants.daysBetween(DateTime.fromMillisecondsSinceEpoch(int.parse(profileController.transactionList[i].purchaseTransactionDetails?.expiryTimeMillis ?? '0')).toUtc(), profileController.currentDate).toString());
              }, separatorBuilder: (context,i){
            return SizedBox(
              height: 5,
            );
          }, itemCount: profileController.transactionList.length,)),
          SizedBox(
            height: 8.h,
          ),
        ],
      ),
    );
  }



  Widget subscriptionItemView({required String daysRemaining,String? planId}){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(7)), color: AppColor.whiteColor[100]),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'STANDARD_SUBSCRIPTION'.tr +' '+ (planId==Constants.subscription1Month ? '1_MONTH'.tr : '12_MONTHS'.tr),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    letterSpacing: 0.4,
                    color: AppColor.subTitleColor,
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  daysRemaining+' ' + 'DAYS_REMAINING'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 8.sp,
                    letterSpacing: 0.4,
                    color: AppColor.greenSliderBg,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  width: 0.7,
                  color: AppColor.green.withOpacity(0.1),
                ),
                color: AppColor.green.withOpacity(0.05)),
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.4.h),
            child: Row(
              children: [
                Image.asset(
                  IconAssets.subscribedIcon,
                  width: 16.w,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'SUBCRIBED'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    letterSpacing: 0.4,
                    color: AppColor.greenSliderBg,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
