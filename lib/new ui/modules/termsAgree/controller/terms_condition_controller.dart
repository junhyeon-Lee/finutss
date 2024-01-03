import 'package:finutss/new%20ui/modules/termsAgree/model/terms_condition_model.dart';
import 'package:get/get.dart';

class TermsConditionController extends GetxController {
  RxList<TermsConditionModel> conditionList = RxList([]);

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  getList() {
    List<TermsConditionModel> list = [
      TermsConditionModel(
        false,
        "ACCEPT_ALL".tr,
        '',
        false,
      ),
      TermsConditionModel(
        false,
        "14_YEARS_OF_AGE_OR_OLDER_REQUIRED".tr,
        "FINUTSS_SERVICE_IS_NOT_AVAILABLE_UNDER_THE_AGE_OF_14".tr,
        true,
      ),
      TermsConditionModel(
        false,
        "AGREE_TO_TERMS_OF_SERVICE_REQUIRED".tr,
        '',
        true,
      ),
      TermsConditionModel(
        false,
        "I_AGREE_TO_THE_PRIVACY_POLICY_REQUIRED".tr,
        '',
        true,
      ),
      TermsConditionModel(
        false,
        "GET_NEWS_OF_EVENTS,_BENEFITS_OPTIONAL".tr,
        '',
        false,
      ),
    ];

    conditionList.value = list;
  }
}
