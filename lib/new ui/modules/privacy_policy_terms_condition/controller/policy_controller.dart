import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:finutss/new%20ui/modules/app_setting/service/localization_service_new.dart';
import 'package:finutss/new%20ui/modules/privacy_policy_terms_condition/model/privacy_policy_model.dart';
import 'package:finutss/new%20ui/modules/privacy_policy_terms_condition/service/policy_service.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PolicyController extends GetxController{
  PrivacyPolicyModel? privacyPolicy;
  PrivacyPolicyModel? termsOfService;
  var prefs;
  String selectLanguageCode='';
  String privacyUrl=ApiConstants.privacyPolicyEnglish;
  String termsConditionUrl=ApiConstants.termsOfServiceEnglish;
  RxBool isLoading=true.obs;
  RxString pdfPath=''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    prefs = await SharedPreferences.getInstance();
    selectLanguageCode = prefs.getString(
      LocalizationServiceNew.Selected_Language_CODE,
    ) ??
        "EN";


   // getPrivacyPolicy();
   // getTermsOfService();
  }


  getCurrentLang(){
    isLoading.value=true;
    selectLanguageCode = prefs.getString(
      LocalizationServiceNew.Selected_Language_CODE,
    ) ??
        "EN";
    if(selectLanguageCode=="KO"){
      privacyUrl=ApiConstants.privacyPolicyKorean;
      termsConditionUrl=ApiConstants.termsOfServiceKorean;
    }else{
      privacyUrl=ApiConstants.privacyPolicyEnglish;
      termsConditionUrl=ApiConstants.termsOfServiceEnglish;
    }

  }

  getPrivacyPolicy(){
    getCurrentLang();
    createFileOfPdfUrl(privacyUrl).then((f) {
      pdfPath.value = f.path;
      isLoading.value=false;
    });
  }

  getTermsCondition(){

    getCurrentLang();
    createFileOfPdfUrl(termsConditionUrl).then((f) {
      pdfPath.value = f.path;
      isLoading.value=false;
    });
  }



  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

/*

  getPrivacyPolicy() async {
    try {
      isLoading.value=true;
      if(selectLanguageCode=="KO"){
        privacyUrl=ApiConstants.privacyPolicyKorean;
      }else{
        privacyUrl=ApiConstants.privacyPolicyEnglish;
      }
      privacyPolicy = await PolicyService.getPolicy(privacyUrl);
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      isLoading.value=false;
    }
  }

  getTermsOfService() async {
    try {
      isLoading.value=true;
      if(selectLanguageCode=="KO"){
        termsConditionUrl=ApiConstants.termsOfServiceKorean;
      }else{
        termsConditionUrl=ApiConstants.termsOfServiceEnglish;
      }
      termsOfService = await PolicyService.getPolicy(termsConditionUrl);
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      isLoading.value=false;
    }
  }
*/


  Future<File> createFileOfPdfUrl(String url1) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      final url = url1;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      isLoading.value=false;
      print("error------>Start download file from internet!");
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}