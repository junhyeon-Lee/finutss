import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/qna_controller.dart';
import 'package:finutss/domain/controller/qna_replay_controller.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/expandable_text_field.dart';
import 'package:finutss/presentation/widgets/common_widgets/rounded_decoration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';

class InquiryHistoryDetailsPage extends StatelessWidget {
  final _qnAReplayController = Get.put(QnAReplayController());
  final _authController = Get.put(AuthController());
  final ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    _qnAReplayController.callPaginateApi(isFirst: true);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print("_recommandController.addListener");
        if (_qnAReplayController.hasNextPage) {
          _qnAReplayController.page = _qnAReplayController.page + 1;
          _qnAReplayController.callPaginateApi();
        }
      }
    });
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GetBuilder<QnAReplayController>(builder: (qnAReplayController) {
        return Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadiusDirectional.circular(20)),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
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
                    customText(
                        text:
                            "[${"${QnAController.getQnACategory(qnAReplayController.selectedQnA["qnaCategory"])}".tr}] ${qnAReplayController.selectedQnA["name"]}",
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    size15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                          text:
                              "${LocalDB.convertDateFormat(qnAReplayController.selectedQnA["createdAt"], "yyyy-MM-dd")}",
                          fontSize: 14,
                        ),
                        customText(
                          text: "${QnAController.getStatus(qnAReplayController.selectedQnA["status"])}".tr,
                          fontSize: 14,
                        ),
                      ],
                    ),
                    size5,
                    Expanded(
                      child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [
                              Container(
                                width: Get.width,
                                padding: EdgeInsets.all(16.r),
                                decoration: roundedDecoration(color: colorBackgroundSilver, radius: 12),
                                child: customText(
                                    height: 1.5,
                                    text: "${qnAReplayController.selectedQnA["content"]}",
                                    fontSize: 14,
                                    fontColor: Color(0xff7F8391)),
                              ),
                              size10,
                              for (var comment in qnAReplayController.docs) makeComment(comment),
                              size10,
                            ],
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10, top: 10),
                      child: Column(
                        children: [
                          expandableTextField(
                              hintText: 'TYPE_HERE'.tr, controller: qnAReplayController.commentTextController),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: customButton(
                                text: 'COMMENT'.tr,
                                textSize: 16,
                                fontWeight: FontWeight.bold,
                                width: Get.width,
                                height: 48,
                                radius: 15,
                                onTapFunction: () {
                                  qnAReplayController.writeComment();
                                }),
                          )
                        ],
                      ),
                    )
                  ],
                ),
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
        );
      }),
    );
  }

  Widget fromMsg(comment) {
    return Column(
      children: [
        _date(LocalDB.convertDateFormat(comment["createdAt"], "yyyy-MM-dd")),
        Container(
          width: Get.width,
          padding: EdgeInsets.all(16.r),
          decoration: roundedDecoration(color: colorBackgroundSilver, radius: 12),
          child: customText(height: 1.5, text: "${comment["content"]}", fontSize: 14, fontColor: Color(0xff7F8391)),
        ),
        size10,
      ],
    );
  }

  Widget toMsg(comment) {
    return Column(
      children: [
        _date(LocalDB.convertDateFormat(comment["createdAt"], "yyyy-MM-dd"), isLeftAlign: true),
        Container(
            width: Get.width,
            padding: EdgeInsets.all(16.r),
            decoration: roundedDecoration(color: Color(0xffCDD5E9), radius: 12),
            child: customText(height: 1.5, text: "${comment["content"]}", fontSize: 14, fontColor: Colors.white)),
        size10,
      ],
    );
  }

  Widget _date(date, {bool isLeftAlign = false}) {
    return Row(
      mainAxisAlignment: isLeftAlign ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        customText(
          fontColor: Color(0xff7F8391),
          text: date ?? '',
          fontSize: 14,
        ),
      ],
    );
  }

  Widget makeComment(comment) {
    if (comment["created"]["id"] != _authController.user?.userId)
      return toMsg(comment);
    else
      return fromMsg(comment);
    // ,
    // toMsg(qnAReplayController),
  }
}
