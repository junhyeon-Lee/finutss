import 'dart:developer';

import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/wallet_model.dart';
import 'package:finutss/new%20ui/modules/store/model/subscription_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';

class WalletService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<SuccessModel> buyEPSubscription(
      {required Map<String, dynamic> body}) async {
    try {
      final request = await _networkAPICall.post(ApiConstants.buyEPSubscription, body,header: {
        "Authorization" :  await SharedPrefs.getToken(),
      });
      if (request != null) {
        return SuccessModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {}
    return SuccessModel();
  }


  static Future<SubscriptionModel> getWalletTransaction() async {
    try {
      Map<String,dynamic> body={
        'status' : 'successful',
        'type' : 'subscription-credit'
      };
      final request = await _networkAPICall.get(ApiConstants.walletTransaction + ApiConstants.getParamsFromBody(body),header: {
        "Authorization" :  await SharedPrefs.getToken(),
      });
      if (request != null) {
        return SubscriptionModel.fromJson(request);
      }
    } catch (e) {
      log("getWalletTransaction log In Api Error $e");
      rethrow;
    } finally {}
    return SubscriptionModel();
  }



  static Future<WalletModel> getWallet() async {
    try {
      final request = await _networkAPICall.get(ApiConstants.buyEPSubscription,header: {
        "Authorization" :  await SharedPrefs.getToken(),
      });
      if (request != null) {
        print("getWallet ${WalletModel.fromJson(request)}");
        return WalletModel.fromJson(request);
      }
    } catch (e,st) {
      print("getWallet Error Message: $e : $st");
      rethrow;
    } finally {}
    return WalletModel();
  }

}