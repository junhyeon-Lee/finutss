import 'package:finutss/constants.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/domain/controller/map_controller.dart';
import 'package:finutss/domain/controller/workout_in_controller.dart';
import 'package:finutss/presentation/screens/track_screens/track_distance_screen.dart';
import 'package:finutss/presentation/widgets/daily_track_container.dart';
import 'package:finutss/presentation/widgets/user_notic_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyTrackScreen extends StatelessWidget {
  final MapController mapController = Get.put(MapController());
  final WorkoutInController workoutInController =
      Get.put(WorkoutInController());
  final ScrollController scrollController;

  DailyTrackScreen({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    workoutInController.callPaginateApi();
    return Column(
      children: [
        size20,
        dailyTrackContainer(
          track: mapController.jsonTrack,
          title: "DAILY_TRACK".tr,
          context: context,
          isNumberOfPeople: true,
          onViewButtonPressed: () async {
            var guest = await LocalDB.getInt("userAsGuest");
            guest == null
                ? Get.dialog(UserNoticeDialog())
                : Get.to(() => TrackDistanceScreen());
          },
        ),
        size15,
        dailyTrackContainer(
            track: mapController.jsonTrackOfTomorrow,
            context: context,
            isNumberOfPeople: false,
            isViewButton: false,
            isTomorrowMap: true,
            title: 'TOMORROW'.tr,
            backgroundColor: colorLightSilver),
        size30,
      ],
    );
  }
}
