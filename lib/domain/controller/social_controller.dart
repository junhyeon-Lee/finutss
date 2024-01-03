import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/data/graphql_operation/queries/FollowQueries.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SocialController extends GetxController {
  /* -------------------------------- variables ------------------------------- */
  TextEditingController searchController = new TextEditingController();
  bool isBeingSearched = true;
  bool isFollowed = false;
  int selectedTag = 0;
  int? radioValue = 0;
  AspectRatio aspectRatio = AspectRatio(
    aspectRatio: 16 / 9,
  );
  onInit() {
    getFollower();
    getFollowing();
    super.onInit();
  }

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
    'assets/images/user_image.png',
    'assets/images/user_image.png',
    'assets/images/user_image.png',
    'assets/images/user_image.png',
    'assets/images/user_image.png',
    'assets/images/user_image.png',
    'assets/images/user_image.png',
    'assets/images/user_image.png',
    'assets/images/user_image.png',
  ];

  List sugestionList = [
    '#mutual friend',
    '#similartime',
    '#AroundYou',
  ];

  List searchlist = [];

  List declareOptions = [
    "Violent Theats",
    "Harassment",
    "Identify thef",
    "Spam and Fraud",
    "Privacy Infringemnt",
    "Not applicable",
  ];

  List withdrawalReasons = [
    'I_DONT_HAVE_TIME_TO_WORKOUT'.tr,
    'LACK_OF_WORKOUT_CONTENT'.tr,
    'SERVICE_DISRUPTIONS_A_LOT_OF_ERRORS'.tr,
    'USE_OTHER_SERVICES'.tr,
    'ITS_HARD_TO_USE_THE_SERVICE_AND_ITS_UNCOMFORTABLE'.tr,
    'OTHER_REASONS'.tr,
  ];

  var socialInfo;
  RxInt getFollowerCount = 0.obs;
  RxInt getFollowingCount = 0.obs;

  /* -------------------------------- functions ------------------------------- */

  void searchFreind(String value, var controller) {
    searchController.text = value;
    controller.update();
  }

  getFollower() async {
    print("------getFollower--------");
    try {
      Map<String, dynamic> values = Map<String, dynamic>();
      var userInfo = await GlobalBloc().queryRepo(FollowQueries.GET_FOLLOWERS_COUNT, values);
      getFollowerCount(userInfo['data']['getFollowersCount']);
      print("-----getFollower--------${userInfo['data']['getFollowersCount']}");
      return true;
    } catch (e, stacktrace) {
      print('Exception: ' + e.toString());
      print('Stacktrace: ' + stacktrace.toString());
      LocalDB.snackbar("Error", "Error login ${e.toString()}");
      return false;
    }
  }

  getFollowing() async {
    print("------getFollowing--------");
    try {
      Map<String, dynamic> values = Map<String, dynamic>();
      var userInfo = await GlobalBloc().queryRepo(FollowQueries.GET_FOLLOWING_COUNT, values);
      getFollowingCount(userInfo['data']['getFollowingCount']);
      print("-----getFollowing--------${userInfo['data']['getFollowingCount']}");
      return true;
    } catch (e, stacktrace) {
      print('Exception: ' + e.toString());
      print('Stacktrace: ' + stacktrace.toString());
      LocalDB.snackbar("Error", "Error login ${e.toString()}");
      return false;
    }
  }

  void handleRadioValueChange(int? value) {
    radioValue = value;

    switch (radioValue) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        break;
    }
    update();
  }

  static callFollow(userId, followUserId) async {
    print("callFollow----->$followUserId");

    var response = await GlobalBloc().queryMutate(FollowQueries.FOLLOW_USER, {"value": true, "followId": followUserId});
    print("callFollow--response--->$response");
    if (response["data"] == null) {
      LocalDB.snackbar("Error", response["message"]);
    }
  }

  static callUnfollow(socialId) async {
    print("callUnfollow----->${socialId}");

    var response =
        await GlobalBloc().mutateRequest(FollowQueries.FOLLOW_USER, {"value": false, "followId": socialId}, true);
    print("response ${response}");
    if (response["data"] == null) {
      LocalDB.snackbar("Error", response["message"]);
    }
  }
}
