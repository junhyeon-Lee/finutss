import 'dart:developer';

import 'package:finutss/new%20ui/modules/app_setting/model/unsubscribe_model.dart';
import 'package:finutss/new%20ui/modules/report_screen/model/report_model.dart';
import 'package:finutss/new%20ui/modules/report_screen/service/report_service.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ReportScreenController extends GetxController {
  RxInt selectedUnsubscribeIndex = (-1).obs;
  final TextEditingController desController = TextEditingController();
  RxList<ReportModel> reportList = RxList([]);
  String? userID;
  String? trackId;
  String? commentId;


  final List<UnsubscribeModel> unsubscribeModelList = <UnsubscribeModel>[
    UnsubscribeModel(tittle: "A_VIOLENT_THREAT".tr,value: 'Violent Theats'),
    UnsubscribeModel(tittle: "TEASING_OR_HARASSMENT".tr,value: 'Harassment'),
    UnsubscribeModel(tittle: "THE_ACT_OF_STEALING_ONE'_NAMES".tr,value: "the act of stealing one' names"),
    UnsubscribeModel(tittle: "SPAM_AND_FRAUD".tr,value: 'Spam and Fraud'),
    UnsubscribeModel(tittle: "PRIVACY_INFRINGEMENT".tr,value: 'Privacy infringement'),
    UnsubscribeModel(tittle: "NOT_APPLICABLE".tr,value: 'Not Applicable'),
  ];

  void report({required Map<String, dynamic> body}) async {
    try {
      AppLoader(Get.context!);
      ReportModel reportModel = await ReportService.reportUser(body: body);

      RemoveAppLoader();
      if (reportModel.statusCode == Constants.successCode201) {
        Navigation.pop();
        Navigation.pop();
        if(trackId==null){
          Navigation.pop();
        }
        Constants.isOpenScreen=false;
      }
    } catch (e, st) {
      RemoveAppLoader();
      log("Error Message: $e : $st");
    } finally {}
  }
}
