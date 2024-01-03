import 'package:finutss/new%20ui/modules/privacy_policy_terms_condition/controller/policy_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Future<void> termsConditionBottomSheet(BuildContext context) {
  PolicyController controller=Get.find();


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

      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.getTermsCondition();
      });
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
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30.h,
                            ),
                            Text(
                             'TERMS_OF_SERVICE'.tr.toUpperCase(),
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
                              child: Obx(() {
                                print('--------->${controller.pdfPath.value}');
                                return controller.isLoading.value ? CustomVIew.policyShimmer() :  controller.pdfPath.value.isEmpty ? Center(
                                  child: CircularProgressIndicator(),
                                ) :  PDFView(
                                filePath: controller.pdfPath.value,
                                enableSwipe: true,
                                swipeHorizontal: false,
                                autoSpacing: false,
                                pageFling: true,
                                pageSnap: true,
                                fitPolicy: FitPolicy.BOTH,
                                preventLinkNavigation: false, // if set to true the link is handled in flutter
                                onRender: (_pages) {

                                },
                                onError: (error) {

                                },
                                onPageError: (page, error) {

                                },
                                onViewCreated: (PDFViewController pdfViewController) {
                                },
                                onLinkHandler: (String? uri) {
                                  print('goto uri: $uri');
                                },
                                onPageChanged: (int? page, int? total) {
                                  print('page change: $page/$total');

                                },
                              );
                              },


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

  String article, dec;

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
