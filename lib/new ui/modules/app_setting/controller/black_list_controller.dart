import 'dart:developer';
import 'package:finutss/helper/toast_helper.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/blackList_model.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/app_setting/service/black_list_service.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BlackListController extends GetxController {
  List<BlockedArray> tempBlackList = [];
  RxList<BlockedArray> blackList = RxList([]);
  RxInt blackListTotalLength = 0.obs;
  RxInt limit = 10.obs;
  RxInt offset = 0.obs;
  RxBool isFirstTimeLoading = true.obs;
  RxBool isLoadRunning = false.obs;
  String previousDate = "";

  final DateFormat dateFormat = DateFormat("yyyy.MM.dd");
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(pagination);
  }


  void pagination() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && blackList.length < blackListTotalLength.value) {
      limit.value = limit.value + 10;
      offset.value = offset.value + 10;
      getBlackList();
    }
  }

  Future<BlackListModel> getBlackList() async {
    try {
      Map<String, dynamic> body = {
        "limit": limit.value,
        "offset": offset.value,
      };
      isLoadRunning.value = true;

      BlackListModel model = await BlackListService.getBlackList(body: body);
      if (model.statusCode == Constants.successCode200) {
        tempBlackList.addAll(model.data?.blockedArray ?? []);

        tempBlackList.sort((a, b){ //sorting in ascending order
          return DateTime.parse(a.updatedAt ?? '').compareTo(DateTime.parse(b.updatedAt ?? ''));
        });


        String previousDate='';
        for(int i=0; i<tempBlackList.length; i++){
          var now = new DateTime.now();
          var formatter = new DateFormat('yyyy-MM-dd');
          String currentDate=dateFormat.format(DateTime.parse(tempBlackList[i].updatedAt ?? formatter.format(now)).toUtc());
          if(currentDate==previousDate){
            tempBlackList[i].showDate=null;
          }else{
            previousDate=dateFormat.format(DateTime.parse(tempBlackList[i].updatedAt ?? formatter.format(now)).toUtc());
            tempBlackList[i].showDate=previousDate;
          }
        }

        blackList.value=[];
        blackList.value.addAll(tempBlackList);

        blackListTotalLength.value = model.data?.count ?? 0;
      }
      return model;
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      isLoadRunning.value = false;
      isFirstTimeLoading.value=false;
    }
    return BlackListModel();
  }

  Future<void> getBlackListLength() async {
    try {
      Map<String, dynamic> body = {
        "limit": 10,
        "offset": 0,
      };
      //blackListTotalLength.value=0;
      BlackListModel model = await BlackListService.getBlackList(body: body);
      if (model.statusCode == Constants.successCode200) {
        blackListTotalLength.value = model.data?.count ?? 0;
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
  }

  Future<SuccessModel> removeUserBlacklist(
      {required String userId, required int index}) async {
    try {
      AppLoader(Get.context!);
      SuccessModel model =
          await BlackListService.removeUserBlackList(userId: userId);
      RemoveAppLoader();
      if (model.statusCode == Constants.successCode200) {
        // ignore: invalid_use_of_protected_member
       // previousDate='';
        blackList.removeAt(index);
        blackList.refresh();
        blackListTotalLength.value--;
        Navigation.pop();
      }
      return model;
    } catch (e, st) {
      RemoveAppLoader();
      log("Error Message: $e : $st");
    } finally {}
    return SuccessModel();
  }

  Future<SuccessModel> addUserBlacklist(
      {required Map<String, dynamic> body}) async {
    try {
      AppLoader(Get.context!);
      SuccessModel model = await BlackListService.addUserBlackList(body: body);
      if (model.statusCode == Constants.successCode201) {
        AppToast.toastMessage(model.message ?? 'User blocked successfully.');
        Navigation.pop();
        getBlackListLength();
        Constants.isOpenScreen=false;
      }
      return model;
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      Navigation.pop();
    }
    return SuccessModel();
  }
}
