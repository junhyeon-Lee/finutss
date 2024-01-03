import 'package:finutss/domain/controller/qna_controller.dart';
import 'package:finutss/domain/controller/qna_replay_controller.dart';
import 'package:finutss/domain/controller/setting_controller.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/presentation/screens/setting_page/contact_pages/inquiry_history_details_page.dart';
import 'package:finutss/presentation/widgets/common_widgets/action_card.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';

class InquiryHistoryPage extends StatelessWidget {
  final _qnAReplayController = Get.put(QnAReplayController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadiusDirectional.circular(20)),
        child: Stack(
          children: [
            Column(
              children: [
                size25,
                /* --------------------------------- heading -------------------------------- */
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customText(text: 'INQUIRY_HISTORY'.tr, fontSize: 24, fontWeight: FontWeight.bold),
                  ],
                ),
                size30,

                /* -------------------------------------------------------------------------- */
                /*                                Inquiry list                               */
                /* -------------------------------------------------------------------------- */
                GetBuilder<QnAController>(builder: (qnAController) {
                  return Expanded(
                      child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: GetBuilder<SettingController>(
                          init: SettingController(),
                          builder: (settingController) {
                            return Column(
                              children: [
                                for (var qna in qnAController.docs)
                                  /* ---------------------------- language listCard ---------------------------- */
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 14.0.h),
                                      child: actionCard(
                                          onTapFunction: () {
                                            _qnAReplayController.setSelectQnA(qna);
                                            Get.dialog(Padding(
                                              padding: EdgeInsets.all(16.r),
                                              child: InquiryHistoryDetailsPage(),
                                            ));
                                          },
                                          isSuffixIconShow: false,
                                          // status: '${inquiry['status']}',
                                          // statusColor: inquiry['status'] == 'Waiting' ? blueColor : null,
                                          heading:
                                              '[${QnAController.getQnACategory(qna['qnaCategory'])}] ${qna['name']}',
                                          description: LocalDB.convertDateFormat(qna['createdAt'], "yyyy-MM-dd"),
                                          status: QnAController.getStatus(qna['status'])   ))
                              ],
                            );
                          }),
                    ),
                  ));
                }),
              ],
            ),
            /* -------------------------------------------------------------------------- */
            /*                                cancel button                               */
            /* -------------------------------------------------------------------------- */
            Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 14.h, right: 16.w),
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: colorBackgroundSilver,
                      child: Icon(
                        CommunityMaterialIcons.window_close,
                        color: Colors.black,
                        size: 24.r,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
