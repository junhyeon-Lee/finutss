import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CloseButtonCustom extends StatelessWidget {
  CloseButtonCustom({Key? key,this.topMargin,required this.onTap}) : super(key: key);

  double? topMargin;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 100.w,
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.only(top: topMargin ?? 63.h,right: 15.w),
              child: Image.asset(
                IconAssets.close,
                scale: 4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
