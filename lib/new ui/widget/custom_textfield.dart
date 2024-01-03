import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? suffixIcon;
  final String? title;
  final String? errorMsg;
  final FormFieldValidator<String>? validator;
  bool? obscureText;
  final Color? fillColor;
  ValueChanged<String>? onChanged;
  int? maxLength;
  double? borderRadius;
  final String? hintText;
  final bool? showBottomErrorMsg;
  final bool? autoFocus;
  final TextStyle? hintStyle;
  final TextInputType? inputType;

  CustomTextField({
    Key? key,
    required this.controller,
    this.suffixIcon,
    this.validator,
    this.title,
    this.errorMsg,
    this.obscureText,
    this.inputType,
    this.showBottomErrorMsg,
    this.fillColor,
    this.onChanged,
    this.maxLength,
    this.autoFocus,
    this.hintText,
    this.hintStyle,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(
        "object ((title?.isEmpty ?? false) && (title?.isEmpty ?? false)) ==>${((title?.isEmpty ?? false) && (errorMsg?.isEmpty ?? false))}");
    return Column(
      children: [
        Row(
          children: [
            (title == null)
                ? SizedBox()
                : Text(
                    title ?? "",
                    style: TextStyle(
                      color: AppColor.subTitleColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp,
                    ),
                  ),
            (errorMsg != null && !(showBottomErrorMsg ?? false))
                ? Expanded(
              child: Text(
                errorMsg ?? "",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'MontserratItalic',
                  color: AppColor.errorTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 11.sp,
                ),
              ),
            ) : SizedBox(),
          ],
        ),

        (showBottomErrorMsg ?? false) ? Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              errorMsg ?? "",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'MontserratItalic',
                color: AppColor.errorTextColor,
                fontWeight: FontWeight.w400,
                fontSize: 11.sp,
              ),
            ),
          ],
        ) : SizedBox(),
        /*  Align(
          alignment: Alignment.topLeft,
          child: Text(
            title ?? "",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 13.sp,
            ),
          ),
        ),*/
        ((title == null) && (errorMsg == null))
            ? SizedBox()
            : SizedBox(
                height: 8.2.h,
              ),SizedBox(
          child: TextFormField(
            // scrollPadding: EdgeInsets.only(
            //   bottom: 100.h,
            // ),
            maxLength: maxLength,
            onChanged: onChanged,
            textAlign: TextAlign.start,
            obscuringCharacter: '*',
            obscureText: obscureText ?? false,
            validator: validator,
            controller: controller,
            autofocus: autoFocus ?? false,
            keyboardType: inputType ?? TextInputType.text,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
            ),
            decoration: InputDecoration(
              hintStyle: hintStyle,
              hintText: hintText,
              isDense: true,
              contentPadding: EdgeInsets.fromLTRB(
                10,
                12.7,
                10,
                12.7,
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
              suffixIcon: suffixIcon,
              suffixIconConstraints: BoxConstraints(
                maxHeight: 35.h,
              ),
              fillColor: fillColor ?? AppColor.textFieldColor,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    borderRadius ?? 8,
                  ),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    borderRadius ?? 8,
                  ),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    borderRadius ?? 8,
                  ),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    8,
                  ),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    borderRadius ?? 8,
                  ),
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
