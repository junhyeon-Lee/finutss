import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Future<void> moreOptionsBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    enableDrag: false,
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.black.withOpacity(0.2),
    builder: (context) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        height: MediaQuery.of(context).size.height * 2,
        width: MediaQuery.of(context).size.width,
        child: SizedBox(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 12.w),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            IconAssets.close,
                            scale: 4,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.elliptical(
                                MediaQuery.of(context).size.width,
                                100.0,
                              ),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 32.h,
                                ),
                                Text(
                                  'OPTION'.tr,
                                  style: TextStyle(
                                    color: AppColor.subTitleColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                                SizedBox(
                                  height: 29.h,
                                ),
                                MoreOptionItem(
                                  title: 'COMMENT'.tr,
                                  iconPath: IconAssets.commentIcon,
                                  onTap: () {},
                                ),
                                MoreOptionItem(
                                  title: "SHARING_CODE".tr,
                                  iconPath: IconAssets.shareUnFill,
                                  onTap: () {},
                                ),
                                MoreOptionItem(
                                  title:
                                      'REPORT'.tr+" ," + "BLOCK_TITLE".tr,
                                  iconPath: IconAssets.blockIcon,
                                  onTap: () {},
                                ),
                                SizedBox(
                                  height: 46.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class MoreOptionItem extends StatelessWidget {
  MoreOptionItem({Key? key, this.title, this.iconPath, this.onTap})
      : super(key: key);

  final String? title;
  final String? iconPath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: Row(
        children: [
          SvgPicture.asset(iconPath ?? ''),
          SizedBox(
            width: 18.w,
          ),
          Text(
            title ?? '',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.alreadyTextColor,
            ),
          )
        ],
      ),
    );
  }
}
