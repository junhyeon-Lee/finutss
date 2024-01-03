import 'package:finutss/new%20ui/modules/user_guide/model/sensor_model.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:get/get.dart';

class UserGuideController extends GetxController {
  List<SensorSliderModel> sliderList = [
    SensorSliderModel(
      ImageAssets.sliderImg1,
      "TUTORIAL_1_1_SUBTITLE_CONNECTION",
      "TUTORIAL_1_1_TEXT_CONNECTION",
    ),
    SensorSliderModel(
      ImageAssets.sliderImg7,
      "TUTORIAL_1_7_SUBTITLE_CHOOSE_EXERCISER",
      "TUTORIAL_1_7_TEXT_CHOOSE_EXERCISER",
    ),
    SensorSliderModel(
      ImageAssets.sliderImg2,
      "TUTORIAL_1_2_SUBTITLE_INDOOR",
      "TUTORIAL_1_2_TEXT_INDOOR",
    ),
    SensorSliderModel(
      ImageAssets.sliderImg3,
      "TUTORIAL_1_3_SUBTITLE_SPIN",
      "TUTORIAL_1_3_TEXT_SPIN",
    ),
    SensorSliderModel(
      ImageAssets.sliderImg4,
      "TUTORIAL_1_4_SUBTITLE_TREADMILL",
      "TUTORIAL_1_4_TEXT_TREADMILL",
    ),
    SensorSliderModel(
      ImageAssets.sliderImg5,
      "TUTORIAL_1_5_SUBTITLE_RUNNING_BOARD",
      "TUTORIAL_1_5_TEXT_RUNNING_BOARD",
    ),
    SensorSliderModel(
      ImageAssets.sliderImg6,
      "TUTORIAL_1_6_SUBTITLE_MOBILE_DEVICE",
      "EXERCISER_MOBILE_DESCRIPTION",
    ),
    SensorSliderModel(
      ImageAssets.sliderImg8,
      "TUTORIAL_1_8_SUBTITLE_SEARCH_FOR_SENSOR",
      "TUTORIAL_1_8_TEXT_SEARCH_FOR_SENSOR",
    ),
    SensorSliderModel(
      ImageAssets.sliderImg9,
      "TUTORIAL_1_9_SUBTITLE_SENSOR_CONNECTION",
      "TUTORIAL_1_9_TEXT_SENSOR_CONNECTION",
    ),
  ];
  RxInt selectedIndex = 0.obs;

  List<SensorSliderModel> onBoardingList = [
    SensorSliderModel(
      ImageAssets.boarding1,
      "ANYWHERE",
      "ANYWHERE_CONTENT",
    ),
    SensorSliderModel(
      ImageAssets.boarding2,
      "ANYTIME",
      "ANYTIME_CONTENT",
    ),
    SensorSliderModel(
      ImageAssets.boarding3,
      "WITH_PEOPLE",
      "WITH_PEOPLE_COTENT",
    ),
    SensorSliderModel(
      ImageAssets.boarding4,
      "STEP_BY_STEP",
      "STEP_BY_STEP_COTENT",
    ),
    SensorSliderModel(
      ImageAssets.boarding5,
      "FITNESS_THAT_FITS_RIGHT",
      "FITNESS_THAT_FITS_RIGHT_COTENT",
    ),
  ];
  RxInt selectedOnBoardingIndex = 0.obs;

  List<SensorSliderModel> workoutGuideList = [
    SensorSliderModel(
      ImageAssets.workoutGuide1,
      "TUTORIAL_2_1_SUBTITLE_WORKOUT",
      "TUTORIAL_2_1_TEXT_WORKOUT",
    ),
    SensorSliderModel(
      ImageAssets.workoutGuide2,
      "TUTORIAL_2_2_SUBTITLE_CONNECTION_CHECK",
      "TUTORIAL_2_2_TEXT_CONNECTION_CHECK",
    ),
    SensorSliderModel(
      ImageAssets.workoutGuide3,
      "TUTORIAL_2_3_SUBTITLE_SENSOR_TEST",
      "TUTORIAL_2_3_TEXT_SENSOR_TEST",
    ),
  ];
  RxInt selectedIndexWorkoutGuide = 0.obs;

  List<SensorSliderModel> bodyInfoGuideList = [
    SensorSliderModel(
      ImageAssets.bodyInfo1,
      "RESULT",
      "TUTORIAL_3_1_TEXT_RESULT",
    ),
    SensorSliderModel(
      ImageAssets.bodyInfo2,
      "TUTORIAL_3_2_SUBTITLE_BODY_INFO",
      "TUTORIAL_3_2_TEXT_BODY_INFO",
    ),
    SensorSliderModel(
      ImageAssets.bodyInfo3,
      "TUTORIAL_3_2_SUBTITLE_BODY_INFO_RECORD",
      "TUTORIAL_3_2_TEXT_BODY_INFO_RECORD".tr,
    ),
  ];
  RxInt selectedIndexBodyInfo = 0.obs;

  List<SensorSliderModel> recordGuideList = [
    SensorSliderModel(
      ImageAssets.recordGuide1,
      "TUTORIAL_4_1_SUBTITLE_WORKOUT_RECORD",
      "TUTORIAL_4_1_TEXT_WORKOUT_RECORD",
    ),
    SensorSliderModel(
      ImageAssets.recordGuide2,
      "TUTORIAL_4_2_SUBTITLE_GOAL",
      "TUTORIAL_4_2_TEXT_GOAL",
    ),
    SensorSliderModel(
      ImageAssets.recordGuide3,
      "TUTORIAL_4_3_SUBTITLE_WORKOUT_HISTORY",
      "TUTORIAL_4_3_TEXT_WORKOUT_HISTORY",
    ),
    SensorSliderModel(
      ImageAssets.recordGuide4,
      "TUTORIAL_4_4_SUBTITLE_LETS_START",
      "TUTORIAL_4_4_TEXT_LETS_START",
    ),
  ];
  RxInt selectedIndexRecord = 0.obs;


}
