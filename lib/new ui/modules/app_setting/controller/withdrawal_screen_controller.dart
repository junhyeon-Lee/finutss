import 'package:finutss/new%20ui/modules/app_setting/model/unsubscribe_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawalScreenController extends GetxController {
  RxInt selectedUnsubscribeIndex = 0.obs;
  TextEditingController approveController = TextEditingController();
  RxBool initialColor = false.obs;
  final List<UnsubscribeModel> unsubscribeModelList = <UnsubscribeModel>[
    UnsubscribeModel(tittle: "I_DONT_HAVE_TIME_TO_WORKOUT".tr,value: "I don't have time to workout"),
    UnsubscribeModel(tittle: "LACK_OF_WORKOUT_CONTENT".tr,value: 'Lack of workout content'),
    UnsubscribeModel(tittle: "SERVICE_DISRUPTIONS_A_LOT_OF_ERRORS".tr,value: 'Service disruptions, a lot of errors.'),
    UnsubscribeModel(tittle: "USE_OTHER_SERVICES".tr,value: 'Use other services'),
    UnsubscribeModel(tittle: "ITS_HARD_TO_USE_THE_SERVICE_AND_ITS_UNCOMFORTABLE".tr,value: "It's hard to use the service and it's uncomfortable."),
    UnsubscribeModel(tittle: "OTHER_REASONS".tr,value: 'Other Reasons'),
  ];
}
