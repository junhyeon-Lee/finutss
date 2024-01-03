import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Future<void> ReceiveMarketingInfoBottomSheet(BuildContext context) {

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
                top: 60.h,
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
                    Expanded(
                      child: Container(
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30.h,
                            ),
                            Text(
                              "GET_NEWS_OF_EVENTS,_BENEFITS_OPTIONAL".tr.toUpperCase(),
                              style: TextStyle(
                                color: AppColor.subTitleColor,
                                fontSize: 18.sp,
                                letterSpacing: 0.2,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'June 10, 2022',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.subTitleColor
                                        .withOpacity(0.7),
                                  ),
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                                SvgPicture.asset(
                                  IconAssets.downArrow,
                                  color: AppColor.downArrowColor,
                                  width: 10.w,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.calibrationCardColor,
                                        borderRadius:
                                            BorderRadius.circular(10.w),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 19.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text:
                                                  'Would you like to receive information such as event and benefit guidance from Finutss?',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13.sp,
                                                height: 1.7,
                                                fontStyle: FontStyle.italic,
                                                fontFamily: 'MontserratItalic',
                                                color: AppColor.subTitleColor
                                                    .withOpacity(0.8),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "According to Article 22(4) of the Privacy Act, you may use the service without having to agree to the optional information.",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily:
                                                        'MontserratItalic',
                                                    fontSize: 13.sp,
                                                    height: 1.7,
                                                    color: AppColor
                                                        .subTitleColor
                                                        .withOpacity(0.8),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Text(
                                            '[Purpose for personal information collection]',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13.sp,
                                              height: 1.8,
                                              color: AppColor.subTitleColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          Text(
                                            'Offer discount coupons, provide benefit information, guide events, personalize services, use of marketing and advertising',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontFamily: 'MontserratItalic',
                                              fontStyle: FontStyle.italic,
                                              fontSize: 13.sp,
                                              height: 1.8,
                                              color: AppColor.subTitleColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 14.h,
                                          ),
                                          Text(
                                            '[Personal Information Collection Entries]',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13.sp,
                                              height: 1.8,
                                              color: AppColor.subTitleColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          Text(
                                            'Mobile number, Email',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontFamily: 'MontserratItalic',
                                              fontStyle: FontStyle.italic,
                                              fontSize: 13.sp,
                                              height: 1.8,
                                              color: AppColor.subTitleColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Text(
                                            '[Holding Period]',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13.sp,
                                              height: 1.8,
                                              color: AppColor.subTitleColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          Text(
                                            'From the date of consent to the withdrawal of membership or withdrawal of consent;',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontFamily: 'MontserratItalic',
                                              fontStyle: FontStyle.italic,
                                              fontSize: 13.sp,
                                              height: 1.8,
                                              color: AppColor.subTitleColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Text(
                                            'Please agree to use marketing to receive advertising information such as events, services, and affiliated services provided by Peanuts.',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13.sp,
                                              height: 1.7,
                                              fontStyle: FontStyle.italic,
                                              fontFamily: 'MontserratItalic',
                                              color: AppColor.subTitleColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Text(
                                            '[Purpose of Collection]',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13.sp,
                                              height: 1.8,
                                              color: AppColor.subTitleColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          Text(
                                            'Offer discount coupons, benefit information, event notifications and opportunities to participate, personal and customized services, marketing and advertising, etc.',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontFamily: 'MontserratItalic',
                                              fontStyle: FontStyle.italic,
                                              fontSize: 13.sp,
                                              height: 1.8,
                                              color: AppColor.subTitleColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Text(
                                            '[Collection Usage]',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13.sp,
                                              height: 1.8,
                                              color: AppColor.subTitleColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          Text(
                                            'Name, mobile number, Email',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontFamily: 'MontserratItalic',
                                              fontStyle: FontStyle.italic,
                                              fontSize: 13.sp,
                                              height: 1.8,
                                              color: AppColor.subTitleColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Text(
                                            '[Holding Period]',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13.sp,
                                              height: 1.8,
                                              color: AppColor.subTitleColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          Text(
                                            'Until withdrawal of membership.',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontFamily: 'MontserratItalic',
                                              fontStyle: FontStyle.italic,
                                              fontSize: 13.sp,
                                              height: 1.8,
                                              color: AppColor.subTitleColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
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

class ArticleTitle extends StatelessWidget {
  ArticleTitle({Key? key, required this.article, required this.dec})
      : super(key: key);

  final String article, dec;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article + "  ",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13.sp,
              color: AppColor.subTitleColor,
            ),
          ),
          Expanded(
            child: Text(
              dec,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: AppColor.greenSliderBg,
              ),
            ),
          )
        ],
      ),
    );
  }
}
