import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonView extends StatelessWidget {
  final VoidCallback? onPressedFunction;
  final Color? color;
  final Color? textColor;
  final String? icon;
  final String? text;
  final double? fontSize;

  ButtonView({
    Key? key,
    this.onPressedFunction,
    this.color,
    this.textColor,
    this.icon,
    this.text,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressedFunction,
      child: Card(
          color: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Container(
              width: 96.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.0.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      icon ?? '',
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Flexible(
                      child: Text(
                        text ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
