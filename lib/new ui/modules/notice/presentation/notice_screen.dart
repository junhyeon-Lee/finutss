import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/notice/controller/notice_controller.dart';
import 'package:finutss/new%20ui/modules/notice/presentation/notice_detail_bottom_sheet.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NoticeScreen extends StatelessWidget {
  NoticeScreen({Key? key}) : super(key: key);
  final NoticeController controller = Get.put(NoticeController());
  final AppSettingController settingController = Get.find();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.noticeList.value = [];
      Map<String, dynamic> body={
        'category' : 'notice',
        'language': settingController.selectedLanguageCode.value.toString()
      };
      controller.getNotice(body: body,isCallRepeatApi: true);
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: Column(
          children: [
            CustomSettingRow(
              title: 'NOTICE'.tr.toUpperCase(),
              fontsize: 18.sp,
            ),
            Expanded(
              child: Obx(
                () => controller.isLoadingNotice.value ? CustomVIew.listViewShimmer() : controller.noticeList.length==0 ? CustomVIew.errorMessageShow('THERE_IS_NO_NOTICE_FOUND') : Obx(() => ListView.separated(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 18.w),
                    itemBuilder: (context, i) {
                      return listViewItem(context,
                        title: controller.noticeList[i].title,
                        date: controller.noticeList[i].createdAt,
                        status: controller.noticeList[i].status,
                        content: controller.noticeList[i].content,
                        category: controller.noticeList[i].category ?? '',
                      );
                    },
                    separatorBuilder: (context, i) {
                      return SizedBox(
                        height: 10.h,
                      );
                    },
                    itemCount: controller.noticeList.length)),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget listViewItem(BuildContext context,{String? title, String? status, String? date,String? content,required String category}) {
    final DateFormat timeFormat = DateFormat('dd MMM yyyy');
    DateTime tempDate = new DateFormat("yyyy-MM-ddThh:mm:ss").parse(date ?? '2022-10-01').toUtc();
    String createdDate = timeFormat.format(tempDate);

    final DateFormat timeFormatKo = DateFormat('yyyy MM dd');
    DateTime tempDateKo = new DateFormat("yyyy-MM-ddThh:mm:ss").parse(date ?? '2022-10-01').toUtc();
    String createdDateKo = timeFormatKo.format(tempDateKo);

    return GestureDetector(
      onTap: () {
        noticeDetailBottomSheet(context,title: title,content: content);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(8.w),
        ),
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                      color: AppColor.subTitleColor,
                    ),
                  ),
                  SizedBox(
                    height: 4.5.h,
                  ),
                  //노티스,어나운스,업데이트,
                  Row(
                    children: [

                      Text(
                        category=="Notice"?"NOTICE".tr:"UPDATE".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 11.sp,
                          color: category.toLowerCase() == 'notice' ? AppColor.orangeColor : AppColor.green,
                        ),
                      ),


                      Container(
                        height: 9.h,
                        width: 1.w,
                        color: AppColor.dividerColor,
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                      ),
                      Text(
                        settingController.selectedLanguage.value=="한국어"? createdDateKo:createdDate,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.sp,
                          color: AppColor.subTitleColor.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              IconAssets.rightArrow,
              width: 7.5.w,
            ),
          ],
        ),
      ),
    );
  }
}
