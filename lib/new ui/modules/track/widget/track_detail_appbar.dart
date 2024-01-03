import 'package:finutss/new%20ui/modules/track/controller/track_detail_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/widget/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TrackDetailAppBar extends StatelessWidget {
  TrackDetailAppBar({
    required this.avatar,
    required this.title,
    required this.trackDetailController,
    this.extent = 260,
    Key? key,
  }) : super(key: key);

  final Widget avatar;
  final double extent;
  final String title;
  final TrackDetailController trackDetailController;





  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TransitionAppBarDelegate(
          avatar: avatar,
          title: title,
          trackDetailController: trackDetailController,
          extent: extent > 200 ? extent : 200,
      ),
    );
  }
}

class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  _TransitionAppBarDelegate(
      {required this.avatar, required this.title, required this.trackDetailController, this.extent = 250})
      : assert(extent >= 200, '');

  final Widget avatar;
  final double extent;
  final String title;
  TrackDetailController trackDetailController;

  final _titleMarginTween = EdgeInsetsTween(
    begin: EdgeInsets.only(bottom: 0),
    end: EdgeInsets.only(left: 0, top: 0),
  );
  final _avatarAlignTween = AlignmentTween(begin: Alignment.bottomLeft, end: Alignment.topLeft);


  @override
  double get maxExtent => extent;

  @override
  double get minExtent => 124.h;

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
    return avatar != oldDelegate.avatar || title != oldDelegate.title;
  }

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    final tempVal = maxExtent * 100 / 100;
    final progress = shrinkOffset > tempVal ? 1.0 : shrinkOffset / tempVal;
    final titleMargin = _titleMarginTween.lerp(progress);
    final avatarAlign = _avatarAlignTween.lerp(progress);

    final avatarSize = 160.h - (progress * 10);
    final bottomMargin = 18.h - progress * 18.h;

    return Stack(
      children: <Widget>[


        mapImage(),

        Positioned(
          left: 0,
          top: 0,
          right: 0,
          child: Image.asset(
            ImageAssets.shadowBg,
            height: 50.h,
            fit: BoxFit.fill,
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 100),
          height: 160.h,
          constraints: BoxConstraints(maxHeight: minExtent),
         // color: AppColor.whiteColor,
        ),


        Container(
          width: double.infinity,
          height: 85.h,
          color: AppColor.whiteColor.withOpacity(progress),
          padding: EdgeInsets.only(top: 35.h,left: 20.w,right: 20.w),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: RoundButton(
                    iconPath: IconAssets.backIcon,
                    iconColor: AppColor.backIconColor,
                    iconSize: 15.w,
                    width: 40.w,
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Text(
                    "TRACK_DETAIL".tr,
                    style: TextStyle(
                        letterSpacing: 0.4,
                        color: AppColor.subTitleColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),


        Positioned(
          left: 0,
          right: 0,
          bottom: bottomMargin,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            color: AppColor.whiteColor.withOpacity(progress),
            child: Container(
              height: 40.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                color: AppColor.whiteColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Row(
                children: [
                  Center(child: SvgPicture.asset(IconAssets.trackingLine)),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                    child: Obx(() => Text(
                      trackDetailController.trackDetailModel.value.data?.name ?? '',
                      style: TextStyle(
                          color: AppColor.subTitleColor, fontWeight: FontWeight.w500, fontSize: 12.sp),
                    )),
                  )
                ],
              ),
            ),
          ),
        ),


        Padding(
          padding: titleMargin,
          child: Align(
            alignment: avatarAlign,
            child: Text(
              '',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),

      ],
    );
  }


  Widget mapImage() {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: Container(
        height: 278.h,
        child: Image.asset(
          ImageAssets.map,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

}