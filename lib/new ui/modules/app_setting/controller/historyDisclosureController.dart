import 'dart:developer';

import 'package:finutss/new%20ui/modules/app_setting/model/history_disclosure_model.dart';
import 'package:finutss/new%20ui/modules/app_setting/service/history_disclosure_service.dart';
import 'package:finutss/new%20ui/modules/record/service/user_service.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:get/get.dart';

class HistoryDisclosureController extends GetxController {
  List<HistoryDisclosureModel> historyDisclosure = [
    HistoryDisclosureModel('ALL','all'),
    HistoryDisclosureModel('FRIENDS','friends'),
    HistoryDisclosureModel('PRIVATE','private'),
  ];
  RxInt select = 0.obs;
  RxString selectHistoryDisclosure = ''.obs;

  Future<LoginModel> updateHistoryDisclosure(
      {required Map<String, dynamic> body}) async {
    try {
      AppLoader(Get.context!);
      LoginModel loginModel =
          await HistoryDisclosureService.updateHistoryDisclosure(body: body);
      RemoveAppLoader();
      if (loginModel.statusCode == Constants.successCode200) {}
      return loginModel;
    } catch (e, st) {
      RemoveAppLoader();
      log("Error Message: $e : $st");
    } finally {

    }
    return LoginModel();
  }


  Future getUserInfo() async {
    try {
      LoginModel model = await UserService.getUserInfo();
      if (model.statusCode == Constants.successCode200) {
        selectHistoryDisclosure.value=model.data?.historyDisclosure ?? '';
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
  }
}
