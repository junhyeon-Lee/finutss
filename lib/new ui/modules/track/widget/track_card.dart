import 'package:finutss/new%20ui/modules/home/widget/custom_button.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/cache_network_image.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:finutss/presentation/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';

class TrackCard extends StatelessWidget {
  TrackCard({
    Key? key,
    this.imageTag,
    this.isDoneMarkShow,
    this.circleImagePath,
    this.subTitleText,
    this.titleText,
    required this.onTap,
    this.view,
    this.yearAgo,
    this.createdDate,
    this.galleryView,
    this.comment,
    this.like,
    this.kmtr,
    this.imageUrl,
    this.isUserProfileScreenCard,
    required this.onTapComment,
    required this.onTapLike,
    required this.onTapPhoto,
    this.isLiked, this.cheatIconPath, this.galleryIconPath, this.energyPoint, this.isFree
  }) : super(key: key);
  final bool? imageTag;
  final bool? isDoneMarkShow;
  final String? circleImagePath;
  final String? titleText;
  final String? subTitleText;
  final String? view;
  String? yearAgo;
  final String? createdDate;
  final String? galleryView;
  final String? comment;
  final String? like;
  final String? kmtr;
  final VoidCallback onTap;
  final String? imageUrl;
  final String? cheatIconPath;
  final String? galleryIconPath;
  final bool? isUserProfileScreenCard;
  VoidCallback onTapLike;
  VoidCallback onTapComment;
  VoidCallback onTapPhoto;
  final bool? isLiked;
  int? energyPoint;
  bool? isFree;

  @override
  Widget build(BuildContext context) {
    if (createdDate != null) {
      yearAgo = Constants.convertToAgo(createdDate ?? '');
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.cardGradiant1.withOpacity(0.06),
            spreadRadius: 5,
            blurRadius: 18,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        child: Column(
          children: [
            isUserProfileScreenCard == true
                ? Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'RESULT'.tr,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: AppColor.blueTextColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "3 hours ago",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: AppColor.blueTextColor.withOpacity(0.5),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            IconAssets.locationTime,
                            height: 30.h,
                          ),
                          SizedBox(
                            width: 15.h,
                          ),
                          Text(
                            "",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: AppColor.blueTextColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  )
                : SizedBox(),
            SizedBox(
              height: 2.h,
            ),
            CacheNetworkImageView(
              height: 96.h,
              loader: Center(
                child: CircularProgressIndicator(),
              ),
              noTrack: Center(
                child: SvgPicture.asset(IconAssets.noRecordIcon),
              ),
              imageUrl: imageUrl ?? '',
              imageTag: imageTag ?? false,
              boxfit: BoxFit.cover,
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              children: [
                CustomCircleImageview(
                  width: 36.h,
                  imagePath: circleImagePath ?? '',
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                titleText ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            (isDoneMarkShow ?? false)
                                ? Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.0.w),
                                    child: SvgPicture.asset(
                                      IconAssets.checkMark,
                                      height: 10.h,
                                      width: 10.h,
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Text(
                          subTitleText ?? '',
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColor.subTitleColor.withOpacity(0.6),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10.0.w),
                        child: SvgPicture.asset(
                          IconAssets.profile,
                          height: 16.h,
                          width: 16.h,
                        ),
                      ),
                      Text(
                        (view ?? "0"),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppColor.subTitleColor.withOpacity(0.5),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    yearAgo ?? '1 년전',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColor.subTitleColor.withOpacity(0.5),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconTextBox(galleryIconPath ?? IconAssets.gallery,
                    galleryView ?? '260', onTapPhoto),
                SizedBox(
                  width: 20.w,
                ),
                iconTextBox(cheatIconPath ?? IconAssets.chatIc, comment ?? '500K',
                    onTapComment),
                SizedBox(
                  width: 20.w,
                ),
                iconTextBox(
                  (isLiked ?? false) ? IconAssets.redHeart : IconAssets.heart,
                  like ?? '0',
                  onTapLike,
                ),
              ],
            ),
            SizedBox(
              height: 17.h,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                        color:  (isFree ?? false) ? AppColor.greenSliderBg.withOpacity(0.05) : AppColor.pointBG,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 1,
                          color:  (isFree ?? false) ? AppColor.greenSliderBg.withOpacity(0.10) : AppColor.pointBorder,
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset((isFree ?? false) ? IconAssets.energyPointGreenIcon : IconAssets.energyPointIcon,width: 23.w,),
                        SizedBox(width: 8.w,),
                        Expanded(
                          child: Text(
                            (isFree ?? false) ? 'FREE'.tr : (energyPoint ?? '0').toString()+' '+"POINTS".tr,
                            maxLines: 1,
                            textAlign: (isFree ?? false) ? TextAlign.center : TextAlign.left,
                            style: TextStyle(
                              color:  (isFree ?? false) ? AppColor.greenSliderBg : AppColor.purple,
                              fontWeight: FontWeight.w600,
                              fontSize: (isFree ?? false) ? 16.sp : 13.sp,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 14.w,
                ),
                Expanded(
                  child: Bouncing(
                    duration: Duration(milliseconds: 100),
                    onPressed: onTap,
                    child: CustomButton(
                      title: "VIEW_DETAIL".tr,
                      backgroundColor: AppColor.orangeColor,
                      fontColor: AppColor.whiteColor,
                      borderColor: AppColor.orangeColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      borderRadius: 12,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget iconTextBox(String path, String text, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.whiteColor[200],
            // color: Color(0xFFF2F7FF),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: 12.0.w, top: 8.h, bottom: 8.h, right: 5.w),
            child: Row(children: [
              SvgPicture.asset(
                path,
                height: 14.h,
                width: 14.h,
              ),
              SizedBox(
                width: 11.w,
              ),
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColor.blueTextColor.withOpacity(0.85),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
