import 'package:finutss/new%20ui/modules/track/controller/comment_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SendMessageView extends StatelessWidget {
  SendMessageView({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;
  final CommentController commentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 35.h,
      child: Row(
        children: [
          Obx(() => CustomCircleImageview(width: 35.h,imagePath: commentController.profilePhoto.value,)),
          SizedBox(
            width: 12.w,
          ),
          Expanded(
            child: Container(
              height: 35.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.w),
                  color: AppColor.whiteColor,
                  border: Border.all(width: 1, color: AppColor.bodyLineColor)),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.subTitleColor.withOpacity(
                          0.5,
                        ),
                      ),
                      controller: commentController.controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: "TYPE_YOUR_MESSAGE".tr,
                        hintStyle: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColor.subTitleColor.withOpacity(
                            0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onTap,
                    child: SvgPicture.asset(
                      IconAssets.send,
                      height: 14.h,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
