import 'package:finutss/new%20ui/modules/dash_board_bottom_navi/model/app_bar_model.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  setBottomBarIndex(index) {
    currentIndex.value = index;
  }


  List<AppBarModel> appBarList = [
    AppBarModel(
        leftIconPath: IconAssets.ridingSensor,
        title: "HOME",
        rightIconPath: IconAssets.notificationSvg),
    AppBarModel(
        leftIconPath: IconAssets.runGroupBoySvg,
        title: "RECORD",
        rightIconPath: IconAssets.notificationSvg),
    AppBarModel(
        leftIconPath: IconAssets.ridingSensor,
        title: "TRACK",
        rightIconPath: IconAssets.notificationSvg),
    AppBarModel(
        leftIconPath: '', title: "SOCIAL", rightIconPath: IconAssets.searchSvg),
    AppBarModel(
        leftIconPath: IconAssets.ridingSensor,
        title: "SETTING",
        rightIconPath: IconAssets.notificationSvg),
  ];
}
