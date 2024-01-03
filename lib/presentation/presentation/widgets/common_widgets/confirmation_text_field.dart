import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

Widget confirmationTextField({
  controller,
  buttonText = 'ENTER',
  onPressFunction,
  isButtonInTextField = true,
  hint = '',
}) {
  return Row(
    children: [
      Expanded(
        child: Container(
          height: 50.h,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(12.r), border: Border.all(color: Color(0xffCDD5E9))),
          child: Row(
            children: [
              size15,
              Expanded(
                child: TextField(
                  controller: controller,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black),
                  decoration: InputDecoration(
                      hintText: hint,
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Color(0xffCDD5E9))),
                ),
              ),
              if (isButtonInTextField)
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r), border: Border.all(color: Colors.transparent)),
                  width: 116.w,
                  child: customButton(
                    onTapFunction: onPressFunction,
                    text: buttonText,
                    fontWeight: FontWeight.bold,
                    textSize: 16,
                    color: colorBlue,
                    height: 46,
                    radius: 10,
                  ),
                ),
            ],
          ),
        ),
      ),
      if (!isButtonInTextField) size15,
      if (!isButtonInTextField)
        Container(
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(12.r), border: Border.all(color: Colors.transparent)),
          width: 116.w,
          child: customButton(
            onTapFunction: onPressFunction,
            text: buttonText,
            fontWeight: FontWeight.bold,
            textSize: 16,
            color: Color(0xffCDD5E9),
            height: 46,
            radius: 10,
          ),
        ),
    ],
  );
}
