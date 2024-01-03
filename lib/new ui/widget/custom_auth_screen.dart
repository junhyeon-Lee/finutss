import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomAuthScreen extends StatelessWidget {
  final Widget? child;
  final Widget? titleChild;
  final double? bottom;
  final double? top;
  final double? right;
  final double? left;
  final bool? showBackIcon;
  final VoidCallback? onTap;

  const CustomAuthScreen(
      {Key? key,
      this.child,
      this.bottom,
      this.top,
      this.right,
      this.left,
      this.onTap,
      this.showBackIcon = false,
      this.titleChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColor.green[100], // transparent status bar
    ));

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColor.green[100],
          child: Stack(
            children: [
              /* Container(
                padding: EdgeInsets.symmetric(
                  vertical: 50.h,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        titleChild == null ? AppString.fitnessThatFitsRight : "",
                        style: TextStyle(
                          letterSpacing: 4,
                          fontFamily: 'jura',
                          color: AppColor.green,
                          fontWeight: FontWeight.w800,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: titleChild,
                    )
                  ],
                ),
                color: AppColor.green[100],
              ),*/

              Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Container(
                    height: top ?? 110.h,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: Text(
                              titleChild == null
                                  ? "FITNESS_THAT_FITS_RIGHT".tr.toUpperCase()
                                  : "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                letterSpacing: 4,
                                fontFamily: 'jura',
                                color: AppColor.green,
                                fontWeight: FontWeight.w800,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 12.w,
                          top: 5.h,
                          child: showBackIcon!
                              ? GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    height: 28.h,
                                    width: 28.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: AppColor.green.withOpacity(0.1),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        IconAssets.backIcon,
                                        height: 9.h,
                                        width: 9.h,
                                        color: AppColor.green,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ),
                        Positioned(
                            bottom: 52.h,
                            left: 0,
                            right: 0,
                            child:
                                titleChild == null ? Container() : titleChild!)
                      ],
                    ),
                  )),
              Positioned(
                bottom: 0,
                top: top ?? 110.h,
                left: left ?? 0,
                right: right ?? 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(
                      MediaQuery.of(context).size.width,
                      100.0,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.elliptical(
                          MediaQuery.of(context).size.width,
                          100.0,
                        ),
                      ),
                    ),
                    child: child,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
