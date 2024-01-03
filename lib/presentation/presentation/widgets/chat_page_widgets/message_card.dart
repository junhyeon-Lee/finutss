import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/user_circle_avatar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

Widget messageCard(
    {userImagePath = 'assets/images/user5.png', senderName = '', message = '', time = '', isSendByMe = false}) {
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!isSendByMe) userAvatar(height: 50, width: 50, imagePath: userImagePath, borderColor: Color(0xffF73A6B)),
        size10,
        Expanded(
          child: Column(
            crossAxisAlignment: isSendByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: isSendByMe ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
                children: [
                  if (!isSendByMe) customText(text: '$senderName', fontColor: colorBackgroundSilver.withOpacity(0.7)),
                  customText(text: '$time', fontColor: colorBackgroundSilver.withOpacity(0.7))
                ],
              ),
              size5,
              Container(
                decoration: BoxDecoration(
                  color: isSendByMe ? colorBlue : colorBackgroundSilver,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                    bottomRight: Radius.circular(isSendByMe ? 0 : 40),
                    bottomLeft: Radius.circular(isSendByMe ? 40 : 0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  child: customText(text: "$message", fontColor: isSendByMe ? Colors.white : Colors.black),
                ),
              ),
              size20,
            ],
          ),
        ),
      ],
    ),
  );
}
