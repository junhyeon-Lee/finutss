import 'package:finutss/constants.dart';
import 'package:finutss/presentation/screens/signup_screens/sign_in_screen/social_login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget socialAccountRow({context}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 29.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialAccountsAvatar(
            imagePath: 'assets/images/social_accounts/kakao_logo_circle_128.png',
            type: 'kakao',
            url: 'https://api.finutss.com/auth/social/kakao'
        ),
        _socialAccountsAvatar(
            imagePath: 'assets/images/social_accounts/google_logo_circle_128.png',
            type: 'google',
            url: 'https://api.finutss.com/auth/social/google'
        ),
      ],
    ),
  );
}

_socialAccountsAvatar({required String imagePath, required String type, required String url}) {
  return IconButton(
    icon: CircleAvatar(
      backgroundColor: colorBackgroundSilver,
      radius: 34.r,
      child: Image.asset(
        imagePath,
        height: 33.h,
        width: 33.w,
      ),
    ),
    onPressed: () {
      Get.to(() => SocialLoginScreen(url: url));

    },
  );
}
