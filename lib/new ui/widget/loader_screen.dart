
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class LoaderScreen extends StatefulWidget {
  LoaderScreen(this.context,{Key? key}) : super(key: key);
  BuildContext context;


  @override
  State<LoaderScreen> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<LoaderScreen> with SingleTickerProviderStateMixin{
   late AnimationController _controller ;



  @override
  void initState() {
    super.initState();

      _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    )..addStatusListener(
          (status) {
        if (status == AnimationStatus.completed) {
          _controller.repeat();
        }
      },
    );

    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
     _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.black.withOpacity(0.4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            RotationTransition(
                turns: Tween(begin: 0.0, end: 4.0).animate(_controller),
              child: SvgPicture.asset(IconAssets.loadingImage, width: 58.w,)),

          SizedBox(
            height: 14.h,
          ),

          Text('CONNECTING'.tr,
            style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w600
            ),),
        ],
      ),
    );
  }
}