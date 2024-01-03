import 'package:finutss/data/models/track.dart';
import 'package:finutss/data/models/users_model.dart';
import 'package:finutss/domain/controller/workout_record_controller.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class OtherUserProfileController extends GetxController {
  User? userInfo;
  var workOutTotal;
  var image, nickName, memo, infoDisclosure;
  late int? follow, follower;

  Track? lastWorkout;

  String workoutType = "all";

  Future<void> setUserInfo(_userInfo) async {
    print("setUserInfo");
    userInfo = _userInfo;
    if (userInfo != null) {
      nickName = userInfo?.username != null ? userInfo?.username : "";
      image = userInfo?.image?.url != null ? userInfo?.image?.url : AuthController.userProfileDefaultPath;
      memo = userInfo?.biography != null ? userInfo?.biography : "";
      ///TODO
      follow =  userInfo?.followingCount != null ? userInfo?.followingCount : 0;
      follower =  userInfo?.followersCount != null ? userInfo?.followersCount : 0;
      //follow = userInfo["follow"] != null ? userInfo["follow"].toString() : "0";
      //follower = userInfo["follower"] != null ? userInfo["follower"].toString() : "0";
      //infoDisclosure = userInfo["infoDisclosure"];

      workOutTotal = await WorkoutRecordController.callApiRecordTotal(userInfo?.userId);
      var result = await WorkoutRecordController.callPaginateApi();
      lastWorkout = result;
    } else {
      nickName = "";
      image = AuthController.userProfileDefaultPath;
      memo = "";
      follow = 0;
      follower = 0;
    }

    update();
  }
}
