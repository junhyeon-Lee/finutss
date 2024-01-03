import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/contact_us/controller/contact_us_controller.dart';
import 'package:finutss/new%20ui/modules/contact_us/presentation/inquiry_history_Dialog.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/user_model.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InquiryHistoryScreen extends StatefulWidget {
  InquiryHistoryScreen({Key? key}) : super(key: key);

  @override
  State<InquiryHistoryScreen> createState() => _InquiryHistoryScreenState();
}

class _InquiryHistoryScreenState extends State<InquiryHistoryScreen> {
  ContactUsController controller = Get.find();

  final AppSettingController settingController = Get.find();

  DateFormat dateFormat = DateFormat("dd MMM yyyy");
  DateFormat dateFormatKo = DateFormat("yyyy MM dd");
  String userId = '';
  String userNicName='';
  LogInUser? userName = LogInUser();
  Future<void> getUserId() async {
    userId = await SharedPrefs.getUserId();
    LogInUser logInUser = (await SharedPrefs.getUser())!;
    userNicName = logInUser.name ?? '';
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getInquiryHistory();
    });
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: Column(
          children: [
            CustomSettingRow(
              title: "INQUIRY_HISTORY".tr.toUpperCase(),
              fontsize: 18.sp,
              horizontalPadding: 20.w,
            ),
            Expanded(
              child: Obx(() => controller.isLoadingHistory.value
                  ? CustomVIew.listViewShimmer()
                  : controller.inquiryHistoryList.length == 0
                      ? CustomVIew.errorMessageShow(
                          'THERE_IS_NO_INQUIRY_HISTORY_FOUND'.tr)
                      : ListView.separated(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              vertical: 18.h, horizontal: 18.w),
                          itemBuilder: (context, i) {
                            return listViewItem(context, i);
                          },
                          separatorBuilder: (context, i) {
                            return SizedBox(
                              height: 10.h,
                            );
                          },
                          itemCount: controller.inquiryHistoryList.length)),
            ),
          ],
        ),
      ),
    );
  }

  Widget listViewItem(BuildContext context, int i) {
    String date = controller.inquiryHistoryList[i].createdAt != null
        ? dateFormat.format(DateTime.parse(
                controller.inquiryHistoryList[i].createdAt ??
                    DateTime.now().toString())
            .toLocal())
        : '';

    String dateKo = controller.inquiryHistoryList[i].createdAt != null
        ? dateFormatKo.format(DateTime.parse(
        controller.inquiryHistoryList[i].createdAt ??
            DateTime.now().toString())
        .toLocal())
        : '';
    String type='';
    if(controller.inquiryHistoryList[i].type.toString()==Constants.typePayment){
      type='ABOUT_PAYMENT'.tr;
    }else if(controller.inquiryHistoryList[i].type.toString().toLowerCase()==Constants.typeOther){
      type='OTHER'.tr;
    }else if(controller.inquiryHistoryList[i].type.toString()==Constants.typeBugReport){
      type='BUG_REPORTING'.tr;
    }else{
      type='HISTORY_SYSTEM'.tr;
    }


    return InkWell(
      onTap: () {
        controller.repliesList.value =
            controller.inquiryHistoryList[i].replies ?? [];
        inquiryHistoryBottomSheet(context,
            id: controller.inquiryHistoryList[i].id ?? "", index: i, userId: userId, Name: userNicName);
        controller.scrollViewScroll();
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
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          controller.inquiryHistoryList[i].title ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                            color: AppColor.subTitleColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 9.w, vertical: 2.3.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: controller.inquiryHistoryList[i].status
                                        .toString()
                                        .toLowerCase() ==
                                    'waiting'
                                ? AppColor.purple.withOpacity(0.2)
                                : AppColor.blue.withOpacity(0.2)),
                        child: Text(
                          (controller.inquiryHistoryList[i].status ?? '')
                                      .toLowerCase() == 'waiting' ? 'WAITING'.tr : 'COTACT_US_COMPLETE'.tr,
                          style: TextStyle(
                            color: controller.inquiryHistoryList[i].status
                                        .toString()
                                        .toLowerCase() ==
                                    'waiting'
                                ? AppColor.purple
                                : AppColor.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 7.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Text(
                        type,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 11.sp,
                          color: controller.inquiryHistoryList[i].type
                                      .toString()
                                      .toLowerCase() ==
                                  Constants.typePayment
                              ? AppColor.orangeColor
                              : AppColor.green,
                        ),
                      ),
                      Container(
                        height: 9.h,
                        width: 1.w,
                        color: AppColor.dividerColor,
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                      ),


                      settingController.selectedLanguage.value=="한국어"?
                      Text(
                        dateKo,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.sp,
                          color: AppColor.subTitleColor.withOpacity(0.7),
                        ),
                      ):
                      Text(
                        date,
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
