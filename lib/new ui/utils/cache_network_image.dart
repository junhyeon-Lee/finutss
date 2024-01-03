import 'package:cached_network_image/cached_network_image.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CacheNetworkImageView extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? borderRadius;
  final bool? imageTag;
  final Widget? loader;
  final Widget? noTrack;
  final BoxFit? boxfit;

  CacheNetworkImageView(
      {this.height,
      required this.imageUrl,
      this.borderRadius,
      this.imageTag = false,
      this.loader,
      this.noTrack,
      this.boxfit
      });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height ?? 120.h,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius ?? 8),
          ),
          image: DecorationImage(
            image: imageProvider,
            fit: boxfit ?? BoxFit.contain,
            // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
          ),
        ),
        child: imageTag == false
            ? null
            : Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.darkPink,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Editor’s Pick',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
      placeholder: (context, url) =>
          loader ??
          Center(child: SvgPicture.asset(IconAssets.emptyProfileIcon)),
      errorWidget: (context, url, error) => noTrack ?? Center(child: SvgPicture.asset(IconAssets.emptyProfileIcon)),
    );
  }
}
