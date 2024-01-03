import 'package:finutss/presentation/screens/edit_body_info_screens/body_info_navigation.dart';
import 'package:finutss/presentation/screens/workout_screens/map_page.dart';
import 'package:finutss/presentation/widgets/dialogs/sensor_dialogs/exerciser_dialog.dart';
import 'package:finutss/presentation/widgets/dialogs/tutorial/tutorial_dialog.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_controller.dart';

class TutorialController extends GetxController {
  int tutorialIndex = 0;
  var guideIndex = 0;

  late SharedPreferences _prefs;

  HomeController _homeController = Get.put(HomeController());

  var userGuideFromSettings;

  List<TutorialModel> guide1Sensor = [
    TutorialModel(
        title: 'TUTORIAL_1_TITLE_SENSOR',
        pageTitle: 'TUTORIAL_1_1_SUBTITLE_CONNECTION',
        imagePath: 'assets/images/userGuide/ug1_1.png',
        tutorialText: 'TUTORIAL_1_1_TEXT_CONNECTION'),
    TutorialModel(
        title: 'TUTORIAL_1_TITLE_SENSOR',
        pageTitle: 'TUTORIAL_1_2_SUBTITLE_INDOOR',
        imagePath: 'assets/images/userGuide/ug1_2.png',
        tutorialText: 'TUTORIAL_1_2_TEXT_INDOOR'),
    TutorialModel(
        title: 'TUTORIAL_1_TITLE_SENSOR',
        pageTitle: 'TUTORIAL_1_3_SUBTITLE_SPIN',
        imagePath: 'assets/images/userGuide/ug1_3.png',
        tutorialText: 'TUTORIAL_1_3_TEXT_SPIN'),
    TutorialModel(
        title: 'TUTORIAL_1_TITLE_SENSOR',
        pageTitle: 'TUTORIAL_1_4_SUBTITLE_TREADMILL',
        imagePath: 'assets/images/userGuide/ug1_4.png',
        tutorialText: 'TUTORIAL_1_4_TEXT_TREADMILL'),
    TutorialModel(
        title: 'TUTORIAL_1_TITLE_SENSOR',
        pageTitle: 'TUTORIAL_1_5_SUBTITLE_RUNNING_BOARD',
        imagePath: 'assets/images/userGuide/ug1_5.png',
        tutorialText: 'TUTORIAL_1_5_TEXT_RUNNING_BOARD'),
    TutorialModel(
        title: 'TUTORIAL_1_TITLE_SENSOR',
        pageTitle: 'TUTORIAL_1_6_SUBTITLE_CHOOSE_EXERCISER',
        imagePath: 'assets/images/userGuide/ug1_6.png',
        tutorialText: 'TUTORIAL_1_6_TEXT_CHOOSE_EXERCISER'),
    TutorialModel(
        title: 'TUTORIAL_1_TITLE_SENSOR',
        pageTitle: 'TUTORIAL_1_7_SUBTITLE_SEARCH_FOR_SENSOR',
        imagePath: 'assets/images/userGuide/ug1_7.png',
        tutorialText: 'TUTORIAL_1_7_TEXT_SEARCH_FOR_SENSOR'),
    TutorialModel(
        title: 'TUTORIAL_1_TITLE_SENSOR',
        pageTitle: 'TUTORIAL_1_8_SUBTITLE_SENSOR_CONNECTION',
        imagePath: 'assets/images/userGuide/ug1_8.png',
        tutorialText: 'TUTORIAL_1_8_TEXT_SENSOR_CONNECTION'),
  ];

  List<TutorialModel> guide2Workout = [
    TutorialModel(
        title: 'TUTORIAL_2_TITLE_WORKOUT',
        pageTitle: 'TUTORIAL_2_1_SUBTITLE_WORKOUT',
        imagePath: 'assets/images/userGuide/ug2_1.png',
        tutorialText: 'TUTORIAL_2_1_TEXT_WORKOUT'),
    TutorialModel(
        title: 'TUTORIAL_2_TITLE_WORKOUT',
        pageTitle: 'TUTORIAL_2_2_SUBTITLE_CONNECTION_CHECK',
        imagePath: 'assets/images/userGuide/ug2_2.png',
        tutorialText: 'TUTORIAL_2_2_TEXT_CONNECTION_CHECK'),
    TutorialModel(
        title: 'TUTORIAL_2_TITLE_WORKOUT',
        pageTitle: 'TUTORIAL_2_3_SUBTITLE_SENSOR_TEST',
        imagePath: 'assets/images/userGuide/ug2_3.png',
        tutorialText: 'TUTORIAL_2_3_TEXT_SENSOR_TEST'),
  ];

  List<TutorialModel> guide3BodyInfo = [
    TutorialModel(
        title: 'TUTORIAL_3_TITLE_BODY_INFO',
        pageTitle: 'TUTORIAL_3_1_SUBTITLE_RESULT',
        imagePath: 'assets/images/userGuide/ug3_1.png',
        tutorialText: 'TUTORIAL_3_1_TEXT_RESULT'),
    TutorialModel(
        title: 'TUTORIAL_3_TITLE_BODY_INFO',
        pageTitle: 'TUTORIAL_3_2_SUBTITLE_BODY_INFO',
        imagePath: 'assets/images/userGuide/ug3_2.png',
        tutorialText: 'TUTORIAL_3_2_TEXT_BODY_INFO'),
    TutorialModel(
        title: 'TUTORIAL_3_TITLE_BODY_INFO',
        pageTitle: 'TUTORIAL_3_2_SUBTITLE_BODY_INFO_RECORD',
        imagePath: 'assets/images/userGuide/ug3_3.png',
        tutorialText: 'TUTORIAL_3_2_TEXT_BODY_INFO_RECORD'),
  ];

  List<TutorialModel> guide4Record = [
    TutorialModel(
        title: 'TUTORIAL_4_TITLE_RECORD',
        pageTitle: 'TUTORIAL_4_1_SUBTITLE_WORKOUT_RECORD',
        imagePath: 'assets/images/userGuide/ug4_1.png',
        tutorialText: 'TUTORIAL_4_1_TEXT_WORKOUT_RECORD'),
    TutorialModel(
        title: 'TUTORIAL_4_TITLE_RECORD',
        pageTitle: 'TUTORIAL_4_2_SUBTITLE_GOAL',
        imagePath: 'assets/images/userGuide/ug4_2.png',
        tutorialText: 'TUTORIAL_4_2_TEXT_GOAL'),
    TutorialModel(
        title: 'TUTORIAL_4_TITLE_RECORD',
        pageTitle: 'TUTORIAL_4_3_SUBTITLE_WORKOUT_HISTORY',
        imagePath: 'assets/images/userGuide/ug4_3.png',
        tutorialText: 'TUTORIAL_4_3_TEXT_WORKOUT_HISTORY'),
    TutorialModel(
        title: 'TUTORIAL_4_TITLE_RECORD',
        pageTitle: 'TUTORIAL_4_4_SUBTITLE_LETS_START',
        imagePath: 'assets/images/userGuide/ug4_4.png',
        tutorialText: 'TUTORIAL_4_4_TEXT_LETS_START'),
  ];

  List<TutorialModel>? tutorials;

  final int SensorIndex = 0;
  final int WorkoutIndex = 1;
  final int BodyInfoIndex = 2;
  final int RecordIndex = 3;

  assignGuideValue(guideNo) {
    switch (guideNo) {
      case 0:
        tutorials = guide1Sensor;
        break;
      case 1:
        tutorials = guide2Workout;
        break;
      case 2:
        tutorials = guide3BodyInfo;
        break;
      case 3:
        tutorials = guide4Record;
        break;
      default:
        // tutorials = guide1Sensor;
        break;
    }
    update();
  }

  clearCache() {
    _prefs.setInt('guideIndex', 0);
  }

  nextTutorial() {
    print('nextTutorial tutorialIndex $tutorialIndex : guideIndex $guideIndex');
    tutorialIndex++;
    if (tutorialIndex == tutorials!.length) {
      if (userGuideFromSettings) {
        return Get.back();
      }

      tutorialIndex = 0;
      _prefs.setInt('guideIndex', guideIndex + 1);
      print('### -= guideIndex + 1 = ${guideIndex + 1}');
      switch (guideIndex) {
        case 0:
          Get.back();
          return Get.dialog(ExerciserDialog(), barrierDismissible: false);
        case 1:
          Get.back();

          _homeController.navBarIndex = 1;
          _homeController.update();

          return Get.to(() => MapPage());
        case 2:
          Get.back(closeOverlays: true);
          return Get.to(() => BodyInfoNavigation(), preventDuplicates: false);
        default:
          return Get.back();
      }
    }
    update();
  }

  previousTutorial() {
    tutorialIndex--;
    if (tutorialIndex < 0) tutorialIndex = 0;
    update();
  }

  valueToAssignGuideAndGuideIndex(val, {fromSettings = false}) {
    guideIndex = val;
    tutorialIndex = 0;
    userGuideFromSettings = fromSettings;

    assignGuideValue(guideIndex);
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    _prefs = await SharedPreferences.getInstance();
    //_prefs.setInt('guideIndex', 0);
    // if(!userGuideFromSettings)
    //   guideIndex = _prefs.getInt('guideIndex')??0;
    // // if guideIndex is at max value then we don't show this guide again
    // assignGuideValue(guideIndex);

    valueToAssignGuideAndGuideIndex(_prefs.getInt('guideIndex') ?? 0);
  }

  Future<void> showTotorial(int index) async {
    var guideIndex = _prefs.getInt('guideIndex') ?? 0;
    if (guideIndex == index) {
      valueToAssignGuideAndGuideIndex(guideIndex);
      Get.dialog(TutorialDialog(), barrierDismissible: false);
      //WidgetsBinding.instance.addPostFrameCallback((_) => showProfileDialog(context));
    }
  }

  Future<void> showSensorTutorial(int index) async {
    valueToAssignGuideAndGuideIndex(index);
    Get.dialog(TutorialDialog(), barrierDismissible: false);
  }
}

class TutorialModel {
  String title;
  String imagePath;
  String pageTitle;
  String tutorialText;

  TutorialModel(
      {this.tutorialText = 'tutorial 1', this.pageTitle = 'page title 1', this.imagePath = '', this.title = 'title 1'});
}
