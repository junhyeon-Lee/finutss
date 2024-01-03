import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SliderIndicator extends StatelessWidget {
  SliderIndicator({Key? key,required this.listLength,required this.selectedIndex, required this.iconSize,required this.height}) : super(key: key);

 final int listLength;
 final RxInt selectedIndex;
 final double iconSize;
 final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
            color: AppColor.greenSliderBg.withOpacity(0.1),
            borderRadius: BorderRadius.circular(50),
          ),
          height: height,
          padding: EdgeInsets.symmetric(
              horizontal: 15.w),
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              return Obx(
                    () => Container(
                      child: Center(
                        child: SvgPicture.asset(selectedIndex == i
                        ? IconAssets.selectDot
                        : IconAssets.unSelectDot,
                        width: selectedIndex == i ? iconSize : iconSize -1,),
                      ),
                    ),
              );
            },
            separatorBuilder: (context, i) {
              return SizedBox(
                width: 12.w,
              );
            },
            itemCount: listLength,
          )),
    );
  }
}
