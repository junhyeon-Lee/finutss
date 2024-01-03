import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PeopleCardView extends StatelessWidget {
  PeopleCardView({Key? key, this.onTap, this.name, this.image})
      : super(key: key);
  final VoidCallback? onTap;
  final String? name;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(
            11.w,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.cardGradiant1.withOpacity(0.06),
              blurRadius: 10.0,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 9.h,
            horizontal: 4.w,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 1.h,
              ),
              CustomCircleImageview(
                width: 50.w,
                imagePath: image ?? "",
              ),
              Spacer(),
              Text(
                name ?? "William",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                  color: AppColor.subTitleColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
