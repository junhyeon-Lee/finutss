import 'package:finutss/new%20ui/modules/app_setting/controller/historyDisclosureController.dart';
import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> historyDisclosureBottomSheet(BuildContext context) {
  final HistoryDisclosureController controller = Get.find();
  controller.select.value = controller.historyDisclosure.indexWhere((note) =>
      note.title.toString().toLowerCase() ==
      controller.selectHistoryDisclosure.value.toString().toLowerCase());

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
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Spacer(),
            CloseButtonCustom(
              onTap: () {
                Get.back();
              },
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(
                    MediaQuery.of(context).size.width,
                    74.0,
                  ),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  top: 34.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'HISTORY_DISCLOSURE'.tr.toUpperCase(),
                      style: TextStyle(
                        color: AppColor.blueTextColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    ListView.separated(
                      itemCount: controller.historyDisclosure.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            controller.select.value = index;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.calibrationCardColor,
                              borderRadius: BorderRadius.circular(
                                8.w,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 18.w, vertical: 15.h),
                            child: Row(
                              children: [
                                Obx(
                                  () => Image.asset(
                                    index == controller.select.value
                                        ? IconAssets.checkBoxSelect
                                        : IconAssets.checkBoxUnSelect,
                                    width: 21.w,
                                  ),
                                ),
                                SizedBox(
                                  width: 24.w,
                                ),
                                Text(
                                  controller.historyDisclosure[index].title
                                      .tr,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.blueTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 13.h,
                        );
                      },
                    ),

                    SizedBox(
                      height: 35.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: CancelSaveButton(
                        onTapSave: () {
                          Navigation.pop();
                          Map<String, dynamic> body = {
                            "historyDisclosure": controller
                                .historyDisclosure[controller.select.value].value,
                          };
                          controller.updateHistoryDisclosure(body: body).then(
                            (value) {
                              controller.selectHistoryDisclosure.value =
                                  controller.historyDisclosure[
                                      controller.select.value].title;
                              //controller.getHistoryDisclosure();
                            },
                          );
                        },
                        onTapCancel: () {
                          Navigation.pop();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 48.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
