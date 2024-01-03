import 'package:finutss/new%20ui/modules/subcription/model/pass_by_user_model.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:get/get.dart';

class SubSubscriptionController extends GetxController {
  RxList<UserPassByModel> UserPassByList = RxList([]);
  List<String> reasonList = [
    "I_DONT_HAVE_TIME_TO_WORKOUT".tr,
    "LACK_OF_WORKOUT_CONTENT".tr,
    "SERVICE_DISRUPTIONS_A_LOT_OF_ERRORS".tr,
    "USE_OTHER_SERVICES".tr,
    "ITS_HARD_TO_USE_THE_SERVICE_AND_ITS_UNCOMFORTABLE".tr,
    "OTHER_REASONS".tr
  ];
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  getList() {
    UserPassByList.add(
      UserPassByModel(
        name: "BitGaram",
        subTitle: "Byung-ho, long time no see. How have you been?",
        date: "FOLLOW_USER",
        image: ImageAssets.boy,
        color: AppColor.purple,
      ),
    );
    UserPassByList.add(
      UserPassByModel(
        name: "William",
        subTitle: "Byung-ho, long time no see. How have you been?",
        date: "FOLLOW_USER",
        image: ImageAssets.women,
        color: AppColor.green,
      ),
    );
    UserPassByList.add(
      UserPassByModel(
        name: "Jimin",
        subTitle: "Byung-ho, long time no see. How have you been?",
        date: "FOLLOW_USER",
        image: ImageAssets.arm,
        color: AppColor.blue,
      ),
    );
    UserPassByList.add(
      UserPassByModel(
        name: "Baek-hyun",
        subTitle: "Byung-ho, long time no see. How have you been?",
        date: "PASSED_BY",
        image: ImageAssets.bridge,
        color: AppColor.lightRedColor,
      ),
    );
    UserPassByList.add(
      UserPassByModel(
        name: "Chae-Yeong",
        subTitle: "Byung-ho, long time no see. How have you been?",
        date: "PASSED_BY",
        image: ImageAssets.signInBg,
        color: AppColor.stepGreenColor,
      ),
    );
    UserPassByList.add(
      UserPassByModel(
        name: "Dae-Seong",
        subTitle: "Byung-ho, long time no see. How have you been?",
        date: "PASSED_BY",
        image: ImageAssets.flower,
        color: AppColor.orangeColor,
      ),
    );
  }
}
