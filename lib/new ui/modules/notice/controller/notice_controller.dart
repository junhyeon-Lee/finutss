import 'dart:developer';

import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/modules/notice/model/notice_model.dart';
import 'package:finutss/new%20ui/modules/notice/service/notice_service.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:get/get.dart';

class NoticeController extends GetxController{


  RxList<NoticeArray> noticeList=RxList([]);
  RxList<NoticeArray> eventList=RxList([]);
  RxBool isLoadingNotice=false.obs;
  String noticeErrorMsg="THERE_IS_NO_INQUIRY_HISTORY_FOUND".tr;
  String eventErrorMsg="THERE_IS_NO_INQUIRY_HISTORY_FOUND".tr;

  AppSettingController settingController = Get.find();


  getNotice({required Map<String, dynamic> body,required bool isCallRepeatApi}) async {
    try {
      isLoadingNotice.value=true;
      NoticeModel model = await NoticeService.getNotice(body: body);
      if (model.statusCode == Constants.successCode200) {
        noticeList.value.addAll(model.data?.noticeArray ?? []);
        noticeList.refresh();
        if(isCallRepeatApi) {
          Map<String, dynamic> body1 = {
            'category': 'update',
            'language': settingController.selectedLanguageCode.value.toString()
          };
          getNotice(body: body1, isCallRepeatApi: false);
        }
      }else{
        noticeErrorMsg=model.message ?? '';
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      isLoadingNotice.value=false;
    }
  }


  getEvent({required Map<String, dynamic> body,required bool isCallRepeatApi}) async {
    try {
      isLoadingNotice.value=true;
      NoticeModel model = await NoticeService.getNotice(body: body);
      if (model.statusCode == Constants.successCode200) {
        eventList.value.addAll(model.data?.noticeArray ?? []);
        eventList.refresh();
        if(isCallRepeatApi) {
          Map<String, dynamic> body = {
            'category': 'announcement',
            'language': settingController.selectedLanguageCode.value.toString()
          };
          getEvent(body: body, isCallRepeatApi: false);
        }
      }else{
        eventErrorMsg=model.message ?? '';
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      isLoadingNotice.value=false;
    }
  }
}