import 'dart:developer';

import 'package:finutss/new%20ui/in_app_purchase_service/app_purchase_service.dart';
import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/store/model/detail_model.dart';
import 'package:finutss/new%20ui/modules/store/model/energy_model.dart';
import 'package:finutss/new%20ui/modules/store/model/purchase_model.dart';
import 'package:finutss/new%20ui/modules/store/model/store_model.dart';
import 'package:finutss/new%20ui/modules/store/service/wallet_service.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/log_utils.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  RxList<StoreModel> storeList = RxList([]);
  RxList<EnergyModel> energyList = RxList([]);
  List<DetailModel> itemList=[
    DetailModel('STORE_UNLIMITED_DAILY_TRACK_ACCESS',false),
    DetailModel('STORE_UNLIMITED_ACCESS_TO_CREATOR_META_TRACKS',false),
    DetailModel('STORE_UNLIMITED_CHAT_DURING_WORKOUT',false),
    DetailModel('STORE_PARTICIPATION_IN_SPECIAL_EVENTS',false),
    DetailModel('STORE_PRIORITIZE_LABORATORY_FUNCTION',false),
  ];
  RxBool isShow = false.obs;
  RxBool isShowCard = false.obs;
  RxInt selectedIndex=(-1).obs;

  @override
  void onInit() {
    super.onInit();
    getList();
    getEnergyList();

    LogUtils.logMSG('-----StoreController onInit----', StackTrace.empty);


  }

  callService(){
    PaymentService().initConnection();

    PaymentService().showMessageStreamController?.stream.listen((value) async {
      PurchaseModel messageValue = value;
      LogUtils.logMSG('--AppPurchase-----showMessageStreamController----messageValue-->${messageValue}', StackTrace.empty);
      if (messageValue.purchaseToken!=null) {

        LogUtils.logMSG('--AppPurchase-----token------product id------>${messageValue.purchaseToken}------->${messageValue.productId}', StackTrace.empty);
        Map<String, dynamic> body={
          'purchaseToken' : messageValue.purchaseToken,
          'googleProductId' : messageValue.productId
        };
        byEPSubscriptionPlan(body: body,productId: messageValue.productId ?? '');

        Future.delayed(const Duration(seconds: 4), () {
          PaymentService().getPastPurchases();
        });
      } else {
        Get.snackbar(
          messageValue.errorMsg ?? '',
          "failed",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          borderRadius: 20,
          margin: const EdgeInsets.all(15),
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      }
    });
  }



  getList() {
    storeList.add(StoreModel('STORE_1_MONTH','₩16,500','STORE_THE_FIRST_MONTH_AFTER_SIGNING_UP_IS_FREE','STORE_1_MONTH','STORE_FIRST_MONTH_FREE',itemList,'TRY_FOR_FREE',Constants.subscription1Month));
    storeList.add(StoreModel('STORE_12_MONTHS','₩198,000','STORE_1_MONTH_SPECIAL_DISCOUNT_APPLIED','STORE_12_MONTHS','STORE_SPECIAL_DISCOUNT',itemList,'₩198,000',Constants.subscription12Month));
  }


  getEnergyList(){
    energyList.add(EnergyModel('STORE_ENERGY_POINT','PURCHASE_A_TRACK_AS_AN_EP','10,000','8,000','2,000','11,000',true,Constants.EP10000));
    energyList.add(EnergyModel('STORE_ENERGY_POINT','PURCHASE_A_TRACK_AS_AN_EP','4,800','4,000','800','5,500',false,Constants.EP4800));
    energyList.add(EnergyModel('STORE_ENERGY_POINT','PURCHASE_A_TRACK_AS_AN_EP','2,700','2,400','300','3,300',false,Constants.EP2700));
    energyList.add(EnergyModel('STORE_ENERGY_POINT','PURCHASE_A_TRACK_AS_AN_EP','900','800','100','1,100',false,Constants.EP900));
  }


  byEPSubscriptionPlan(
      {required Map<String, dynamic> body,required String productId}) async {
    try {
      AppLoader(Get.context!);
      SuccessModel model = await WalletService.buyEPSubscription(body: body);

      RemoveAppLoader();
      if (model.statusCode == Constants.successCode200) {

        String title;
        if(productId==Constants.subscription1Month || productId==Constants.subscription12Month){
          title='subcribed successfully';
        }else{
          title='purchased successfully';
        }
        Get.snackbar(
          title,
          "succeed",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          borderRadius: 20,
          margin: const EdgeInsets.all(15),
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );

        AppSettingController settingController=Get.find();
        settingController.getWallet().then((value) {
          if(productId==Constants.subscription1Month || productId==Constants.subscription12Month){
            settingController.getWalletTransaction();
          }
        });
      } else {
        Get.snackbar(
          model.message ?? model.error ?? '',
          "failed",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          borderRadius: 20,
          margin: const EdgeInsets.all(15),
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      }
    } catch (e, st) {
      RemoveAppLoader();
      log("Error Message: $e : $st");
    } finally {

    }
  }


  @override
  void dispose() {
    PaymentService().dispose();
    super.dispose();
  }
}
