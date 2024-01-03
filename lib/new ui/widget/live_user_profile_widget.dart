import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LiveUserProfileWidget extends StatelessWidget {
  final String userProfile;
  final String userName;
  final String userDis;
  final String currentUserId;
  final String userId;
  final VoidCallback? onTap;
  final VoidCallback? onTapUserIcon;
  final bool? isFollowing;


  LiveUserProfileWidget({
    this.onTap,
    this.onTapUserIcon,
    required this.userDis,
    required this.userName,
    required this.userProfile,
    required this.currentUserId,
    required this.userId,
    this.isFollowing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.5.h),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.w),
            color: AppColor.whiteColor[100],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 11,
          ),
          margin: EdgeInsets.only(bottom: 1.4),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  CustomCircleImageview(
                    width: 55.w,
                    imagePath: userProfile,
                  ),

                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: TextStyle(color: AppColor.subTitleColor, fontSize: 12.sp, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Text(
                          userDis,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(fontSize:11,fontWeight: FontWeight.w500,color: AppColor.subTitleColor.withOpacity(0.8)),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 2.w,),
                  currentUserId!=userId ? InkWell(
                    onTap: onTapUserIcon,
                    child: SvgPicture.asset(
                      (isFollowing ?? false) ? IconAssets.addUserRightGray : IconAssets.addUser,
                    ),
                  ) : SizedBox()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
