import 'package:cached_network_image/cached_network_image.dart';
import 'package:finutss/data/models/users_model.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

Widget userAvatar(
    {String imagePath = 'assets/images/user5.png',
    borderColor = Colors.black,
    double height = 65,
    double width = 65,
    isOnline = false,
    User? userInfo}) {
  if (userInfo != null) {
    imagePath = (userInfo.image?.url != null ? userInfo.image?.url : AuthController.userProfileDefaultPath)!;
    borderColor = (userInfo.workoutType ?? "Riding") == "Riding" ? colorBlue : colorPink;
    borderColor = colorPink;
  }

  ImageProvider image = AssetImage(imagePath);
  if (imagePath.indexOf('http') != -1) image = NetworkImage(imagePath);


  return CachedNetworkImage(
    imageUrl: imagePath,
    imageBuilder: (context, imageProvider) => Container(
      height: height.r,
      width: width.r,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(color: borderColor, width: 3),
          image: DecorationImage(image: image, fit: BoxFit.cover)),
      child: Stack(
        children: [
          if (isOnline)
            Positioned(
              right: 0,
              top: 7.h,
              child: Container(
                height: 7.h,
                width: 7.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(50.r),
                ),
              ),
            )
        ],
      ),
    ),
    placeholder: (context, url) => CircularProgressIndicator(),
    errorWidget: (context, url, error) =>  Container(
      height: height.r,
      width: width.r,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(color: borderColor, width: 3),
          image: DecorationImage(image: image, fit: BoxFit.cover)),
      child: Stack(
        children: [
          if (isOnline)
            Positioned(
              right: 0,
              top: 7.h,
              child: Container(
                height: 7.h,
                width: 7.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(50.r),
                ),
              ),
            )
        ],
      ),
    )
  );
}
