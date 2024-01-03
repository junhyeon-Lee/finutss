import 'package:finutss/data/models/ad.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:finutss/data/graphql_operation/queries/AdQuery.dart';
import 'package:finutss/data/models/workout_Total_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  GetWorkoutTotalObject? getWorkoutTotalObject;
  var jsonAdsList = [];
  int bottomNavIndex = 0;
  /* --------------------------------- varible -------------------------------- */
  int promoSliderPage = 0;
  bool isComplete = false;
  int navBarIndex = 0;
  int introductionSliderPage = 0;

  var isLoading = false.obs;

/* ---------------------------------- list ---------------------------------- */
  List imageList = [
    'assets/images/user_image.png',
    'assets/images/user5.png',
    'assets/images/user6.png',
    'assets/images/user_image.png',
    'assets/images/user5.png',
    'assets/images/user6.png',
    'assets/images/user6.png',
    'assets/images/user_image.png',
  ];

  List<Map> kmSelectionList = [
    {'title': 'SHORT'.tr, 'text': '3.70', 'unitText': ' km'},
    {'title': 'HALF'.tr, 'text': '6.78', 'unitText': ' min'},
    {'title': 'FULL'.tr, 'text': '15.4', 'unitText': ' kcal'}
  ];

  /* -------------------------------- function -------------------------------- */
  bottomNavBarIndex(int index) {
    navBarIndex = index;
    update();
  }

  callApiAds() {
    isLoading(true);
    Map<String, dynamic> params = Map<String, dynamic>();

    GlobalBloc().queryRepo(ADQueries.ADS, params, true).then((response) {
      isLoading(false);

      update();


      var ads = response['data']['getAds'];
      if (response["data"] != null) {

        ads.forEach((v) {
          jsonAdsList.add(new Ad.fromMap(v));
        });

      } else {
        Get.snackbar(
          "Error".tr,
          "show ad".tr,
        );
      }
    });
  }
}
