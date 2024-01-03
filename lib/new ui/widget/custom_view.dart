import 'package:finutss/new%20ui/modules/track/widget/most_popular_card.dart';
import 'package:finutss/new%20ui/modules/track/widget/track_card.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:finutss/new%20ui/widget/draw_horizontal_line.dart';
import 'package:finutss/new%20ui/widget/shimmer/shimmer_from_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomVIew {
  static Widget subscriptionHistoryItem() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.calibrationCardColor,
        borderRadius: BorderRadius.circular(10.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 14.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PAY_AUTO_MONTH".tr,
                  maxLines: 3,
                  style: TextStyle(
                      color: AppColor.subTitleColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  '21.09.05 - 22.09.05',
                  maxLines: 3,
                  style: TextStyle(
                    color: AppColor.subTitleColor.withOpacity(0.8),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  'P314N-3457-4248-1234',
                  maxLines: 3,
                  style: TextStyle(
                    color: AppColor.orangeColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
              ],
            ),
          ),
          SvgPicture.asset(IconAssets.closeIcon)
        ],
      ),
    );
  }

  static Widget subscriptionHistoryItemRight() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.calibrationCardColor,
        borderRadius: BorderRadius.circular(10.w),
      ),
      padding: EdgeInsets.symmetric(vertical: 18.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PAY_AUTO_MONTH'.tr,
                            maxLines: 3,
                            style: TextStyle(
                                color: AppColor.subTitleColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.2),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text(
                            '21.09.05 - 22.09.05',
                            maxLines: 3,
                            style: TextStyle(
                              color: AppColor.subTitleColor.withOpacity(0.8),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text(
                            'P314N-3457-4248-1234',
                            maxLines: 3,
                            style: TextStyle(
                              color: AppColor.orangeColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(IconAssets.rightIcon)
                  ],
                ),
                SizedBox(
                  height: 17.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'PRICE'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                        color: AppColor.subTitleColor,
                      ),
                    ),
                    Text(
                      'W9,900',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: AppColor.subTitleColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 11.h,
                ),
              ],
            ),
          ),
          discountPaymentItemview(
            'DISCOUNT'.tr,
            'May Promo',
            '- W9,900',
          ),
          discountPaymentItemview(
            'ESTIMATED_PAYMENT'.tr,
            'Octobor (KAKAO PAY)',
            'W9,900',
          ),
          SizedBox(
            height: 24.h,
          ),
          CustomSliderButton(
            title: 'RECEIPT'.tr,
            onTap: () {
              Navigation.pushNamed(Routes.receiptScreen);
            },
            isCancelButton: false,
            width: 128.w,
            height: 33.h,
            fontSize: 14.sp,
            letterSpacing: 0.4,
          ),
          SizedBox(
            height: 4.h,
          ),
        ],
      ),
    );
  }

  static Widget discountPaymentItemview(
      String title, String des, String amount) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          height: 1.h,
          color: AppColor.dividerColor2,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.subTitleColor,
                    letterSpacing: 0.2),
              ),
              SizedBox(
                height: 6.5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    des,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.subTitleColor.withOpacity(0.7),
                        letterSpacing: 0.2),
                  ),
                  Text(
                    amount,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.subTitleColor,
                        letterSpacing: 0.2),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget unSubscriptionPaymentItem({required VoidCallback onTapClose}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(10.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      child: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PAY_AUTO_MONTH'.tr,
                        style: TextStyle(
                            color: AppColor.subTitleColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      Text(
                        '21.09.05 - 22.09.05',
                        style: TextStyle(
                          color: AppColor.subTitleColor.withOpacity(0.8),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Text(
                        'P314N-3457-4248-1234',
                        style: TextStyle(
                          color: AppColor.orangeColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                    onTap: onTapClose,
                    child: SvgPicture.asset(IconAssets.closeIcon))
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColor.calibrationCardColor,
              borderRadius: BorderRadius.circular(10.w),
            ),
            padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 7.w, vertical: 14.h),
                  child: Text(
                    'ESTIMATED_PAYMENT'.tr,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColor.subTitleColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  height: 1.h,
                  color: AppColor.dividerColor2,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 7.w, vertical: 13.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '(KAKAO PAY)',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                          color: AppColor.subTitleColor.withOpacity(0.7),
                        ),
                      ),
                      Text(
                        'W9,900',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                          letterSpacing: 0.1,
                          color: AppColor.subTitleColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1.h,
                  color: AppColor.dividerColor2,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 7.w, vertical: 14.h),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'W 9,900',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp,
                        color: AppColor.subTitleColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget yourWorkoutHistoryCard({String? hours, String? km, String? kcal}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(
          11.w,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.cardGradiant1.withOpacity(0.06),
            spreadRadius: 7,
            blurRadius: 15,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 17.h),
      child: Column(
        children: [
          workoutHistoryItem(
            'THE_TIME_WITH_FINUTSS'.tr,
            hours ?? '0',
            "HOURS".tr,
          ),
          SizedBox(
            height: 9.h,
          ),
          workoutHistoryItem(
            'THE_LENGTH_WITH_FINUTSS'.tr,
            km ?? '0',
            "KM".tr,
          ),
          SizedBox(
            height: 9.h,
          ),
          workoutHistoryItem(
            'SWEAT_WITH_FINUTSS'.tr,
            kcal ?? '0',
            "KCAL".tr,
          ),
        ],
      ),
    );
  }

  static Widget workoutHistoryItem(String title, String value, String subTitle) {
    return Container(
      height: 54.h,
      decoration: BoxDecoration(
        color: AppColor.calibrationCardColor,
        borderRadius: BorderRadius.circular(
          7.w,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: AppColor.subTitleColor.withOpacity(0.7),
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                letterSpacing: 0.1,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: AppColor.subTitleColor,
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
              letterSpacing: 0.1,
            ),
          ),
          SizedBox(
            width: 6.w,
          ),
          Text(
            subTitle,
            style: TextStyle(
              color: AppColor.subTitleColor.withOpacity(0.5),
              fontWeight: FontWeight.w500,
              fontSize: 10.sp,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }

  static Widget passedRecentlyCard(List<Color> colorList, VoidCallback? onTap) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(11.w),
        boxShadow: [
          BoxShadow(
            color: AppColor.cardGradiant1.withOpacity(0.06),
            spreadRadius: 7,
            blurRadius: 15,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 19.h,
          ),
          Text(
            'WHO_PASSED_BY_RECENTLY'.tr.toUpperCase(),
            style: TextStyle(
              color: AppColor.subTitleColor,
              fontWeight: FontWeight.w700,
              fontSize: 13.sp,
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          SizedBox(
            height: 42.w,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 35.w,
                            width: 35.w,
                            decoration: BoxDecoration(
                                color: colorList[i],
                                borderRadius: BorderRadius.circular(100)),
                            padding: EdgeInsets.all(1.w),
                            child: Image.asset(
                              ImageAssets.women,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            width: 30.w,
                            child: MySeparator(color: AppColor.dashLineColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.w,
                      ),
                      SizedBox(
                        width: 36.w,
                        child: Center(
                          child: Container(
                            height: 3.w,
                            width: 3.w,
                            decoration: BoxDecoration(
                                color: colorList[i],
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                itemCount: colorList.length),
          ),
          SizedBox(
            height: 18.h,
          ),
          GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  IconAssets.search,
                  color: AppColor.orangeColor,
                  width: 13.w,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  'WHO_PASSED_BY_RECENTLY'.tr,
                  style: TextStyle(
                    color: AppColor.orangeColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
        ],
      ),
    );
  }

  static Widget selectItemHeightWeight() {
    return Container(
      height: 38.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColor.whiteColor,
              AppColor.selectBodyGradiant3,
              AppColor.selectBodyGradiant2,
              AppColor.selectBodyGradiant3,
              AppColor.whiteColor
            ]),
      ),
    );
  }

  static Widget selectDecorationPurple() {
    return Container(
      height: 38.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColor.whiteColor,
              AppColor.purpleGradiant1,
              AppColor.purpleGradiant2,
              AppColor.purpleGradiant1,
              AppColor.whiteColor
            ]),
      ),
    );
  }

  static Widget customSelectWheelItem({
    onTap,
    text = '',
    width = double.infinity,
    height = 45,
    isSelect = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: Text(
            text,
            style: isSelect
                ? TextStyle(
                    color: AppColor.blue,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    letterSpacing: 0.5,
                  )
                : TextStyle(
                    color: AppColor.subTitleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    letterSpacing: 0.5,
                  ),
          ),
        ),
      ),
    );
  }

  static Widget socialRowView(
      {VoidCallback? onTapGoggle, VoidCallback? onTapKakao}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTapGoggle,
          child: Image.asset(IconAssets.google, height: 40.h),
        ),
        SizedBox(
          width: 27.w,
        ),
        GestureDetector(
          onTap: onTapKakao,
          child: Image.asset(IconAssets.cheat, height: 40.h),
        ),
      ],
    );
  }

  static Widget noRecordLayout(
      {required String title, bool isShadow = true, bool isLoading = false, double? borderRadius}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 14.w),
        boxShadow: isShadow
            ? [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.06),
                  blurRadius: 18.0,
                ),
              ]
            : [],
      ),
      padding: EdgeInsets.only(top: 20.h, bottom: 30.h),
      child: isLoading
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 27.h),
              child: Column(
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  IconAssets.noRecordIcon,
                  height: 72.h,
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  title.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: AppColor.subTitleColor.withOpacity(0.8),
                  ),
                )
              ],
            ),
    );
  }

  static Widget mostPopularShimmer() {
    return CustomShimmer(
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, int index) {
          return MostPopularCard(
            trackImage: '',
            trackName: '',
            distanceInKm: '',
            description: '',
            userView: '', energyPoint: 0,
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.2,
        ),
      ),
    );
  }

  static Widget trackShimmer() {
    return CustomShimmer(
      child: ListView.separated(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          itemBuilder: (context, i) {
            return TrackCard(
              onTap: () {},
              isDoneMarkShow: true,
              onTapComment: () {},
              onTapLike: () {},
              onTapPhoto: () {},
            );
          },
          separatorBuilder: (context, i) {
            return SizedBox(
              height: 14.h,
            );
          },
          itemCount: 10),
    );
  }

  static Widget userItemView(
      {VoidCallback? onTap,
      String? profilePhoto,
      String? username,
      String? des,
      VoidCallback? onTapUser,
      bool? isFollowing}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 11.8.h, horizontal: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.w),
          color: AppColor.whiteColor,
        ),
        child: Row(
          children: [
            CustomCircleImageview(
              width: 51.h,
              borderSize: 1.3,
              imagePath: profilePhoto ?? '',
            ),
            SizedBox(
              width: 14.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username ?? '',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.subTitleColor,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    des ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.subTitleColor.withOpacity(0.8),
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: onTapUser,
              child: Container(
                width: 50.w,
                height: 50.h,
                padding: EdgeInsets.only(right: 6.w),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(
                    isFollowing ?? false
                        ? IconAssets.addUserRightGray
                        : IconAssets.addUser,

                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget listViewShimmer() {
    return CustomShimmer(
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 18.w),
        itemBuilder: (context, i) {
          return Container(
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(8.w),
            ),
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                          color: AppColor.subTitleColor,
                        ),
                      ),
                      SizedBox(
                        height: 4.5.h,
                      ),
                      Row(
                        children: [
                          Text(
                            '',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 11.sp,
                            ),
                          ),
                          Container(
                            height: 9.h,
                            width: 1.w,
                            color: AppColor.dividerColor,
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                          ),
                          Text(
                            '',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10.sp,
                              color: AppColor.subTitleColor.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset(
                  IconAssets.rightArrow,
                  width: 7.5.w,
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, i) {
          return SizedBox(
            height: 10.h,
          );
        },
        itemCount: 12,
      ),
    );
  }

  static Widget errorMessageShow(String msg,{Color? textColor}) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(ImageAssets.noResultFound),
                SizedBox(height: 40.h),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                    msg.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor ?? AppColor.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  
  static Widget policyShimmer(){
    return CustomShimmer(child: ListView.separated(
      physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        itemBuilder: (context,i){
      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 50.h,
            color: Colors.white,
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            height: 10.h,
            color: Colors.white,
          ),

          SizedBox(height: 10.h),
          Container(
            width: double.infinity,
            height: 22.h,
            color: Colors.white,
          ),
          SizedBox(height: 10.h),
          Container(
            width: double.infinity,
            height: 10.h,
            color: Colors.white,
          ),

        ],
      );
    }, separatorBuilder: (context,i){
      return SizedBox(height: 10.h,);
    }, itemCount: 10),);
  }


  static Widget shimmerUserListView(){
    return CustomShimmer(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 15,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
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
                          imagePath: '',
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
                                '',
                                style: TextStyle(
                                  color: AppColor
                                      .subTitleColor,
                                  fontSize: 12.sp,
                                  fontWeight:
                                  FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 7.h,
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
