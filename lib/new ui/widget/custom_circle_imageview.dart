import 'dart:io';

import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/cache_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class CustomCircleImageview extends StatelessWidget {
  CustomCircleImageview(
      {Key? key,
      this.width,
      this.borderColor,
      this.borderSize,
      this.boxFit,
      this.emptyImage = false,
      this.imagePath = ''})
      : super(key: key);
  final double? width;
  final double? borderSize;
  final Color? borderColor;
  final bool emptyImage;
  final String imagePath;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 50.w,
      height: width ?? 50.w,
      decoration: imagePath == ''
          ? BoxDecoration()
          : BoxDecoration(
        color: AppColor.whiteColor,
              border: Border.all(
                width: borderSize ?? 1.5.w,
                color: borderColor ?? Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0),
              ),
              borderRadius: BorderRadius.circular(100)),
      child: imagePath == '' || imagePath.contains('undefined')
          ? SvgPicture.asset(IconAssets.emptyProfileIcon)
          : ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: imagePath.contains('com.finutss.metatrack.app') ?Image.file(
                      File(imagePath),
                      fit: BoxFit.cover,
                    ) :  CacheNetworkImageView(
                boxfit: boxFit??BoxFit.cover,
                height: width,
                imageUrl: imagePath,
              ),
            ),
    );
  }
}
