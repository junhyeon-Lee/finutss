import 'package:finutss/presentation/animation/shake/Shake.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

Widget customTextField(
    {keyboardType = TextInputType.text,
    textController,
    LabeledGlobalKey? shakeKey,
    textCapitalization = TextCapitalization.none,
    String label = '',
    String hintText = '',
    String errorText = '',
    bool isPasswordField = false,
    bool isObscurePassword = true,
    onPressedFunction,
    onBouncingPressed,
    onObscureButtonPressed,
    validator,
    onSave,
    focusNode}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: () {
          print("TextField on tap");
          SystemChannels.textInput.invokeMethod(
            'TextInput.hide',
          );
          print(
            "TextField on tap$focusNode",
          );
          if (focusNode != null) {
            focusNode.requestFocus();
            print(
              "TextField on tap$focusNode",
            );
          }
        },
        child: Container(
          height: 72.h,
          decoration: BoxDecoration(
            color: colorBackgroundSilver,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 24.w, top: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(text: label, fontColor: colorWhitish, fontSize: 12),
                size5,
                TextFormField(
                  focusNode: focusNode,
                  style: TextStyle(color: colorDarkGrey, fontSize: 15.sp),
                  obscureText: isPasswordField ? isObscurePassword : false,
                  keyboardType: keyboardType,
                  controller: textController,
                  validator: validator,
                  onSaved: onSave,
                  // cursorHeight: 30.h,
                  textCapitalization: textCapitalization,
                  decoration: InputDecoration(
                    // isDense: true,
                    isCollapsed: true,
                    suffix: isPasswordField
                        ? InkWell(
                            onTap: onObscureButtonPressed,
                            child: Padding(
                              padding: EdgeInsets.only(right: 15.0.w),
                              child: Icon(
                                isObscurePassword ? Icons.visibility_off : Icons.remove_red_eye_outlined,
                                size: 18.r,
                              ),
                            ))
                        : null,
                    border: InputBorder.none,
                    hintText: "$hintText",

                    hintStyle: TextStyle(color: Colors.white),
                    // contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // customText(text: errorText, fontColor: Color(0xffFF0000), fontSize: 12)
      ShakeWidget(
        // 4. pass the GlobalKey as an argument
        key: shakeKey,
        // 5. configure the animation parameters
        shakeCount: 2,
        shakeOffset: 4,
        shakeDuration: Duration(milliseconds: 200),
        errorText: errorText,
        // 6. Add the child widget that will be animated
      ),
    ],
  );
}
