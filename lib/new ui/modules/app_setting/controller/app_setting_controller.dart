import 'dart:developer';

import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/controller/login_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/app_setting_model.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/faq_menu.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/faq_model.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/wallet_model.dart';
import 'package:finutss/new%20ui/modules/app_setting/service/faq_service.dart';
import 'package:finutss/new%20ui/modules/app_setting/service/localization_service_new.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/user_model.dart';
import 'package:finutss/new%20ui/modules/sign_in/presentation/sign_in_screen.dart';
import 'package:finutss/new%20ui/modules/sign_in/service/signin_service.dart';
import 'package:finutss/new%20ui/modules/store/model/subscription_model.dart';
import 'package:finutss/new%20ui/modules/store/service/wallet_service.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:yaml/yaml.dart';

class AppSettingController extends GetxController {
  var prefs;
  Rx<LogInUser> logInUser = LogInUser().obs;
  Rx<WalletModel> walletModel = WalletModel().obs;
  RxString selectedLanguageCode = Constants.defaultLocale.languageCode.obs;
  RxString selectedLanguage = Constants.defaultLangName.obs;
  RxInt selectedLanguageIndex = 0.obs;
  RxList<AppSettingModel> CountryList = RxList([]);
  RxDouble speedValue = 50.0.obs;
  RxDouble speedValue1 = 50.0.obs;
  RxInt indexLan = 0.obs;
  RxString version = ''.obs;
  List<FaqMenu> faqMenuList = [
    FaqMenu('ALL', 'ALL'),
    FaqMenu('GENERAL', 'GENERAL'),
    FaqMenu('SENSOR', 'SENSOR'),
    FaqMenu('SERVICE', 'SERVICE'),
    FaqMenu('PAYMENT', 'PAYMENT'),
    FaqMenu('EXERCISER_ETC', 'ETC'),
  ];
  RxInt selectedMenuFaq = 0.obs;
  RxInt selectedFaq = (-1).obs;

  List<FaqArray> faqTempList = [];
  RxList<FaqArray> faqList = RxList([]);

  RxBool showBottomErrorMsg = false.obs;
  var currentDate = new DateTime.now().toUtc();
  RxBool isSubscription = false.obs;
  RxList<TransactionArray> transactionList = RxList([]);

  AppSettingController({Locale? locale}) {
    /*if (locale != null)
      selectedValue = LocalizationServiceNew.getLanguageFromLocale(locale);*/
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    getLanguageList();
    prefs = await SharedPreferences.getInstance();
    getCurrentLanguageName();
    getLanguageCode();
    if (!Constants.isGuest) {
      getCurrentUser();
    }
    getAppVersion();
    isSubscription.value = false;
  }

  getAppVersion() async {
    await rootBundle.loadString("pubspec.yaml").then((yamlValue) {
      var yaml = loadYaml(yamlValue);
      version.value = yaml['version'];
    });
  }

  getCurrentUser() async {
    logInUser.value = (await SharedPrefs.getUser())!;
  }

  getCurrentLanguageName() async {
    selectedLanguage.value = await prefs.getString(
          LocalizationServiceNew.Selected_Language,
        ) ??
        Constants.defaultLangName;
  }

  getLanguageCode() async {
    selectedLanguageCode.value = prefs.getString(
          LocalizationServiceNew.Selected_Language_CODE,
        ) ??
        Constants.defaultLocale.languageCode.toUpperCase();

    String codeLowerCase = selectedLanguageCode.value.toLowerCase();
    showBottomErrorMsg.value = codeLowerCase == Constants.french.toString().toLowerCase() || codeLowerCase == Constants.italian ? true : false;
    Constants.selectLanguageCode = selectedLanguageCode.value;
  }

  setLanguage({required String languageCode, required String languageName}) async {
    LocalizationServiceNew().changeLocale(
      languageCode,
    );
    await prefs.setString(
      LocalizationServiceNew.Selected_Language_CODE,
      languageCode,
    );
    await prefs.setString(
      LocalizationServiceNew.Selected_Language,
      languageName,
    );
    selectedLanguageCode.value = languageCode;
    Constants.selectLanguageCode = selectedLanguageCode.value;
    getCurrentLanguageName();
  }

  getLanguageList() {
    CountryList.add(AppSettingModel("Chinese", Constants.chinese, "中文( 简体)"));
    CountryList.add(AppSettingModel("German", Constants.german, "Deutsche"));
    CountryList.add(AppSettingModel("English(US)", Constants.english, "English (US)"));
    CountryList.add(AppSettingModel("Spanish", Constants.spanish, "Español"));
    CountryList.add(AppSettingModel("French", Constants.french, "Français"));
    CountryList.add(AppSettingModel("Italian", Constants.italian, "Italiano"));
    CountryList.add(AppSettingModel("Japanese", Constants.japanese, "日本語"));
    CountryList.add(AppSettingModel("Korean", Constants.korean, "한국어"));
    CountryList.add(AppSettingModel("Polskie", Constants.polskie, "Polskie"));
    CountryList.add(AppSettingModel("Portuguese", Constants.portuguese, "português"));
  }

  Future<LoginModel> logout() async {
    try {
      AppLoader(Get.context!);
      LoginModel loginModel = await SignInService.logout(body: {});
      return loginModel;
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      RemoveAppLoader();
      goToSignInScreen();
    }
    return LoginModel();
  }

  goToSignInScreen() async {
    Constants.isLogin = false;
    var prefs = await SharedPreferences.getInstance();
    bool isPhoneLanguage = prefs.getBool('PhoneLanguage') ?? true;

    await SharedPrefs.clearUser();
    await SharedPrefs.saveUser(
        isLogin: false, email: '', userName: '', coverPicture: '', description: '', profilePicture: '', token: '', name: '', userId: '');

    final cookieManager = CookieManager();
    cookieManager.clearCookies();
    LoginController loginController = Get.find();
    loginController.getDeviceToken();
    // Navigation.replaceAll(Routes.signIn);
    Navigator.pushAndRemoveUntil<dynamic>(
      Get.context!,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => SignInScreen(),
      ),
      (route) => false, //if you want to disable back feature set to false
    );

    var prefs1 = await SharedPreferences.getInstance();
    prefs1.setString(
      LocalizationServiceNew.Selected_Language_CODE,
      selectedLanguageCode.value,
    );

    final locale = LocalizationServiceNew.getLocaleFromLanguage(selectedLanguageCode.value);
    Get.updateLocale(locale);
    await prefs1.setString('language_code', locale.languageCode);
    await prefs1.setString('country_code', locale.countryCode ?? "");
    prefs1.setBool(
      'PhoneLanguage',
      isPhoneLanguage,
    );
    prefs.setString(LocalizationServiceNew.Selected_Language, selectedLanguage.value);
  }

  // FAQs
  void getParticularFaq(String text) {
    selectedFaq.value = (-1);
    if (text.toUpperCase() == "ALL") {
      faqList.value = faqTempList;
    }
    /*else if (text.toUpperCase() == "ETC") {
      faqList.value = faqTempList
          .where((user) =>
          user.category.toString().toLowerCase()!='general' ||  user.category.toString().toLowerCase()!='sensor' || user.category.toString().toLowerCase()!='service')
          .toList();
    }*/
    else {
      faqList.value = faqTempList.where((user) => user.category.toString().toLowerCase().contains(text.toLowerCase())).toList();
    }
  }

  getFaqs({required Map<String, dynamic> body}) async {
    try {
      AppLoader(Get.context!);
      FaqModel model = await FaqService.getFaqs(body: body);
      if (model.statusCode == Constants.successCode200) {
        faqTempList = model.data?.faqArray ?? [];
        getParticularFaq('all');
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      RemoveAppLoader();
    }
  }

  Future getWallet() async {
    try {
      walletModel.value = await WalletService.getWallet();
    } catch (e, st) {
      print("getWallet Error Message: $e : $st");
    } finally {}
  }

  getWalletTransaction() async {
    try {
      transactionList.clear();
      SubscriptionModel model = await WalletService.getWalletTransaction();

      print("getWalletTransaction Model-------> ${model.data?.transactionArray}");
      List<TransactionArray> transactionTempList = model.data?.transactionArray ?? [];

      for (int a = 0; a < transactionTempList.length; a++) {
        DateTime startDate =
            DateTime.fromMillisecondsSinceEpoch(int.parse(transactionTempList[a].purchaseTransactionDetails?.expiryTimeMillis ?? '0')).toUtc();

        if (startDate.compareTo(currentDate) > 0) {
          isSubscription.value = true;
          if (transactionList.length == 0) {
            transactionList.value.add(transactionTempList[a]);
          } else if (transactionList.length == 1 &&
              transactionList[0].purchaseTransactionDetails?.subscriptionId != transactionTempList[a].purchaseTransactionDetails?.subscriptionId) {
            transactionList.value.add(transactionTempList[a]);
            break;
          }
        }
      }
      transactionList.refresh();

    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {

    }
  }


}
