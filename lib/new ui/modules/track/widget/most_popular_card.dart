import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class MostPopularCard extends StatelessWidget {
  MostPopularCard({Key? key,this.trackImage,this.trackName,this.description,this.userView,this.distanceInKm, this.isShowOnlyUser,required this.energyPoint}) : super(key: key);

  final String? trackImage, trackName, description, userView,distanceInKm;
  bool? isShowOnlyUser;
  int energyPoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.cardGradiant1.withOpacity(0.02),
            spreadRadius: 1,
            blurRadius: 20,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 62.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    trackImage ?? 'https://cutewallpaper.org/21/portland-backgrounds/7783-portland-oregon-desktop-wallpaper.jpg',
                  ),
                ),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.black.withOpacity(0.6),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            distanceInKm ?? '0.0',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 6.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            " " + "KM".tr,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 4.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 9.h,
            ),
            Text(
              trackName ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColor.blueTextColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              description ?? '',
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColor.blueTextColor.withOpacity(0.6),
                fontSize: 9.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            SizedBox(
              height: 9.h,
            ),
            Row(
              children: [
                 Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10.0.w),
                        child: SvgPicture.asset(
                          IconAssets.profile,
                          height: 14.h,
                          width: 14.h,
                        ),
                      ),
                      Text(
                        userView ?? '0K',
                        style: TextStyle(
                          color: AppColor.blueTextColor.withOpacity(0.5),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                (isShowOnlyUser ?? false) ? SizedBox() : Expanded(child: pointView(isFree: energyPoint==0 ?true : false,point: energyPoint.toString())),
              ],
            ),

            SizedBox(
              height: 1.h,
            ),
          ],
        ),
      ),
    );
  }


  Widget pointView({required bool isFree,String? point}){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        border: Border.all(
          width: 0.8,
          color: isFree ? AppColor.greenSliderBg.withOpacity(0.10) : AppColor.pointBorder,
        ),
        color: isFree ? AppColor.greenSliderBg.withOpacity(0.05) : AppColor.pointBG,
      ),
      padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 4.h),
      child: Row(
        children: [
          SvgPicture.asset(isFree ? IconAssets.energyPointGreenIcon : IconAssets.energyPointIcon,width: 18.w,),
          SizedBox(width: 5.w,),
          Expanded(
            child: Text(
              isFree ? 'FREE'.tr : (point ?? ''),
              style: TextStyle(
                color: isFree ? AppColor.greenSliderBg : AppColor.purple,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
