import 'dart:developer';

import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/contact_us/model/inquiry_history_model.dart';
import 'package:finutss/new%20ui/modules/contact_us/model/inquiry_model.dart';
import 'package:finutss/new%20ui/modules/contact_us/service/inquiry_history_service.dart';
import 'package:finutss/new%20ui/modules/record/service/user_service.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:finutss/new%20ui/widget/loader_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController {
  RxList<InquiryArray> inquiryHistoryList = RxList([]);
  RxList<Replies> repliesList = RxList([]);
  String errorMsg = '';
  RxBool isLoadingHistory = false.obs;
  RxBool inquirypost = false.obs;
  TextEditingController replayController = TextEditingController();
  ScrollController scrollController = new ScrollController();

  @override
  void onInit() {
    if(!Constants.isGuest) {
      getUserInfo();
    }
    super.onInit();
  }

  Rx<LoginModel> userModel = LoginModel().obs;
  Future getUserInfo() async {
    try {
      userModel.value = await UserService.getUserInfo();
      if (userModel.value.statusCode == Constants.successCode200) {
        if (userModel.value.data?.bmi != null) {
          Constants.isBodyInfoSelected.value = true;
        }
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
  }

  scrollViewScroll(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500),
        );
      }
    });
  }

  getInquiryHistory() async {
    try {
      isLoadingHistory.value = true;
      InquiryHistoryModel model = await InquiryService.getInquiryHistory();
      if (model.statusCode == Constants.successCode200) {
        inquiryHistoryList.value = model.data?.inquiryArray ?? [];

        inquiryHistoryList.value.sort((a, b){ //sorting in ascending order
          return DateTime.parse(b.createdAt ?? DateTime.now().toString()).compareTo(DateTime.parse(a.createdAt ?? DateTime.now().toString()));
        });
      } else {
        errorMsg = model.message ?? '';
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      isLoadingHistory.value = false;
    }
  }

  updateInquiryHistory(
      {required Map<String, dynamic> body, required String id,required int index}) async {
    try {
      AppLoader(Get.context!);
      SuccessModel model =
          await InquiryService.updateInquiryHistory(body: body, id: id);
      if (model.statusCode == Constants.successCode200) {
        replayController.text='';
        getSpecificInquiryHistory( index: index,historyId: id);
      } else {
        errorMsg = model.message ?? '';
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      RemoveAppLoader();
    }
  }

  postInquiry(
      {required Map<String, dynamic> body}) async {
    try {
      AppLoader(Get.context!);
      InquiryModel model =
      await InquiryService.postInquiry(body: body);
      if (model.statusCode == Constants.successCode200) {
        Navigation.pop();
      } else {
        errorMsg = model.message ?? '';
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      Navigation.pop();
    }
  }



  getSpecificInquiryHistory({required int index,required String historyId}) async {
    try {
      InquiryHistoryModel model = await InquiryService.getInquiryHistory();
      if (model.statusCode == Constants.successCode200) {
        inquiryHistoryList.value = model.data?.inquiryArray ?? [];
        inquiryHistoryList.value.sort((a, b){
          return DateTime.parse(b.createdAt ?? DateTime.now().toString()).compareTo(DateTime.parse(a.createdAt ?? DateTime.now().toString()));
        });

        if( (model.data?.inquiryArray?.length ?? 0)>index) {
          int? historyIndex = model.data?.inquiryArray?.indexWhere((note) {
            return note.id.toString() == historyId.toString();
          });
          if(historyIndex!=-1) {
            repliesList.value = model.data?.inquiryArray?[index].replies ?? [];
          }
        }
        scrollViewScroll();
      } else {
        errorMsg = model.message ?? '';
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
    }
  }
}
