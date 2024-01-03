import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/event/presentation/event_detail_dialog.dart';
import 'package:finutss/new%20ui/modules/notice/controller/notice_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventScreen extends StatelessWidget {
  EventScreen({Key? key}) : super(key: key);
  NoticeController controller = Get.put(NoticeController());
  final AppSettingController settingController = Get.find();


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.eventList.value = [];
      Map<String, dynamic> body={
        'category' : 'event',
        'language': settingController.selectedLanguageCode.value.toString()
      };
      controller.getEvent(body: body,isCallRepeatApi: true);
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: Column(
          children: [
            CustomSettingRow(
              title: "EVENTS".tr.toUpperCase(),
              fontsize: 18.sp,
            ),
            Expanded(
              child: Obx(()=>  controller.isLoadingNotice.value ? CustomVIew.listViewShimmer() : controller.eventList.length==0 ? CustomVIew.errorMessageShow('THERE_IS_NO_EVENT_FOUND') : ListView.separated(
                  physics: BouncingScrollPhysics(),
                  padding:
                  EdgeInsets.symmetric(vertical: 18.h, horizontal: 18.w),
                  itemBuilder: (context, i) {
                    return listViewItem(context, i);
                  },
                  separatorBuilder: (context, i) {
                    return SizedBox(
                      height: 10.h,
                    );
                  },
                  itemCount: controller.eventList.length)),
            ),
          ],
        ),
      ),
    );
  }

  Widget listViewItem(BuildContext context, int i) {
    final DateFormat timeFormat = DateFormat('dd MMM yyyy');
    DateTime tempDate = new DateFormat("yyyy-MM-ddThh:mm:ss").parse(controller.eventList[i].createdAt ?? '2022-10-01').toUtc();
    String createdDate = timeFormat.format(tempDate);

    ///Korea date format
    final DateFormat dateFormatKo = DateFormat("yyyy MM dd");
    DateTime tempDateKo = new DateFormat("yyyy-MM-ddThh:mm:ss").parse(controller.eventList[i].createdAt ?? '2022-10-01').toUtc();
    String createdDateKo = dateFormatKo.format(tempDateKo);

    return GestureDetector(
      onTap: () {
        eventDetailBottomSheet(context,title: (controller.eventList[i].title ?? ''),content: controller.eventList[i].content ?? '');
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
                    controller.eventList[i].title ?? '',
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
                  Row(
                    children: [
                      Text(
                        controller.eventList[i].category=="Event"?
                        "EVENTS".tr:"ANNOUNCE".tr
                        ,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 11.sp,
                          color:AppColor.orangeColor,
                        ),
                      ),
                      Container(
                        height: 9.h,
                        width: 1.w,
                        color: AppColor.dividerColor,
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                      ),
                      Text(
                        settingController.selectedLanguage.value=="한국어"?createdDateKo:createdDate,
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
