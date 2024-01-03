import 'package:finutss/new%20ui/modules/app_setting/model/payment_info_model.dart';
import 'package:finutss/new%20ui/utils/app_string.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:get/get.dart';

class PaymentInfoController extends GetxController {
  RxList<PaymentInfoModel> paymentInfoList = <PaymentInfoModel>[].obs;
  RxInt isSelect = 0.obs;
  RxBool termsSelect = false.obs;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  getList() {
    paymentInfoList.add(
      PaymentInfoModel(
        name: AppString.payco,
        image: ImageAssets.payco,
      ),
    );
    paymentInfoList.add(
      PaymentInfoModel(
        name: AppString.kakaoPay,
        image: ImageAssets.kakaoPay,
      ),
    );
    paymentInfoList.add(
      PaymentInfoModel(
        name: 'MOBILE',
        image: IconAssets.mobileIcon,
      ),
    );
    paymentInfoList.add(
      PaymentInfoModel(
        name: 'CREDIT_CARD',
        image: IconAssets.creditCardIcon,
      ),
    );
  }
}
