import 'package:finutss/new%20ui/modules/invite_friends/report_block_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/user_profile/controller/controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CommentUserView extends StatelessWidget {
  CommentUserView({
    Key? key,
    this.bgColor,
    this.onTap,
    this.profileImage,
    this.userName,
    this.description,
    this.commentCount,
    this.date,
    this.reactionCount,
    required this.isLiked,
    required this.isRepliesComment,
    required this.currentUserId,
    required this.commentId,
    this.onTapLike,
    required this.id,
  }) : super(key: key);
  final Color? bgColor;
  final VoidCallback? onTap;
  final String? profileImage;
  final String? userName;
  final String? description;
  final String? commentCount;
  final String? date;
  final String? reactionCount;
  final String id;
  final String currentUserId;
  final String commentId;
  final bool isLiked;
  final bool isRepliesComment;
  final VoidCallback? onTapLike;
  String timeAgo = '';

  @override
  Widget build(BuildContext context) {
    final userProfileController userController = Get.find();

    if(date!=null) {
      timeAgo = Constants.convertToAgo(date ?? '');
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(
            left: 12.w,
            bottom: 12.h,
            top: 12.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.w),
            color: bgColor ?? AppColor.whiteColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCircleImageview(
                width: 65.w,
                imagePath: profileImage ?? '',
              ),
              SizedBox(
                width: 12.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 1.3.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          userName ?? '',
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.subTitleColor),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Expanded(
                          child: Text(
                            timeAgo,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColor.subTitleColor.withOpacity(0.4)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      description ?? '',
                      style: TextStyle(
                          fontSize: 10.6.sp,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                          color: AppColor.subTitleColor.withOpacity(0.8)),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    isRepliesComment
                        ? SizedBox()
                        : Row(
                            children: [
                              InkWell(
                                onTap: onTapLike,
                                child: Row(
                                  children: [
                                    postText(IconAssets.heartFill,
                                        reactionCount ?? "0",
                                        color: isLiked
                                            ? AppColor.pink
                                            : AppColor.iconColor),
                                    SizedBox(
                                      width: 18.w,
                                    ),
                                  ],
                                ),
                              ),
                              postText(IconAssets.chatFill, commentCount ?? '0'),
                            ],
                          ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ),
              currentUserId!=id ? InkWell(
                onTap: () {
                  reportBlockBottomSheet(context, userId: id,commentId: commentId);
                },
                child: SizedBox(
                  height: 50.h,
                  width: 50.w,
                  child: Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset(
                        IconAssets.sirenIcon,
                        height: 15.h,
                      ),
                    ),
                  ),
                ),
              ) : SizedBox(),

            ],),),

      ),
    );
  }

  Widget postText(String icon, String text, {Color? color}) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          height: 10.h,
          color: color ?? AppColor.iconColor,
        ),
        SizedBox(
          width: 8.w,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.subTitleColor.withOpacity(0.5)),
        ),
      ],
    );
  }
}
