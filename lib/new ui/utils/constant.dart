import 'package:finutss/new%20ui/modules/connection/models/available_devices_model.dart';
import 'package:finutss/new%20ui/modules/connection/models/connection_model.dart';
import 'package:finutss/new%20ui/modules/connection/models/wear_position_model.dart';
import 'package:finutss/new%20ui/modules/home/model/exerciser_card_model.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Constants {
  static const successCode200 = 200;
  static const successCode400 = 400;
  static const successCode403 = 403;
  static const successCode404 = 404;
  static const successCode406 = 406;
  static const successCode500 = 500;
  static const expireCode = 401;
  static const int successCode201 = 201;
  static bool isGuest = false;
  static bool isLogin = false;
  static String running = 'Running';
  static String riding = 'Riding';
  static String run = 'run';
  static String ride = 'ride';
  static String smartWatch = 'SmartWatch';
  static String mobileSensor = 'MobileSensor';
  static String MALE = 'Male';
  static String FEMALE = 'Female';
  static RxBool isSelectMaleFemale = false.obs;
  static RxBool isBodyInfoSelected = false.obs;
  static String drop = 'DROP';
  static String finished = 'FINISHED';
  static String processing = 'PROCESSING';
  static String dropped = 'dropped';
  static String paused = 'paused';
  static String deleted = 'deleted';
  static String currentTrackID = '';
  static String currentTrackImage = '';
  static String like = 'like';
  static String unlike = 'unlike';
  static double trackDistance = 0.0;

  // Language code
  static const String chinese = 'ZH-CN';
  static const String english = 'EN';
  static const String french = 'FR';
  static const String italian = 'IT';
  static const String japanese = 'JA';
  static const String german = 'DE';
  static const String korean = 'KO';
  static const String polskie = 'PL';
  static const String portuguese = 'PT';
  static const String spanish = 'ES';
  static const Locale defaultLocale = Locale('ja', 'JP');
  static const String defaultLangName = '日本語';

  static const String typePayment = 'payment';
  static const String typeHistorySystem = 'historySystem';
  static const String typeBugReport = 'bugReport';
  static const String typeOther = 'other';

  static const int typePhoto = 1;
  static const int typeVideo = 2;


  static int dailyTrackScreen = 0;
  static int mostPopularScreen = 1;
  static int trackDetailScreen = 2;
  static int channelPopularTrack = 3;
  static int channelLatestTrack = 4;
  static int isFollowerScreen = 5;
  static int isFollowingScreen = 6;
  static int isSearchUserScreen = 7;
  static int hotPeople = 8;
  static int recommendedUser = 9;
  static int workoutUser = 10;
  static int isLiveUser = 11;
  static int isFollowDialog = 12;
  static int isCurrentUser = 13;


  static String sender = '1';
  static String receiver = '2';
  static String admin = '3';
  static String selectLanguageCode = '';



  static const String EP900 = 'ep_900';
  static const String EP2700 = 'ep_2700';
  static const String EP4800 = 'ep_4800';
  static const String EP10000 = 'ep_10000';
  static const String subscription1Month = 'subscribe_1month';
  static const String subscription12Month = 'subscribe_12months';


  static RxBool isSelectWearPosition = false.obs;
  static int tempSpeed = 0;
  static WearPosition? wearPosition;

  static int screenCloseCount=0;
  static bool isOpenScreen=false;

  static List<ExerciserModel> exerciserList = <ExerciserModel>[
    ExerciserModel(
      description: "EXERCISER_RIDING_DESCRIPTION",
      mainIcon: IconAssets.girlBike,
      title: "EXERCISER_RIDING",
      topPrefixIcon: IconAssets.bike,
      isSelected: false.obs,
    ),
    ExerciserModel(
      description: "EXERCISER_RUNNING_DESCRIPTION",
      mainIcon: IconAssets.boyRun,
      title: "EXERCISER_RUNNING",
      topPrefixIcon: IconAssets.run,
      isSelected: false.obs,
    ),
    ExerciserModel(
      description: "EXERCISER_MOBILE_DESCRIPTION",
      mainIcon: IconAssets.mobileDevice,
      title: "EXERCISER_MOBILE",
      topPrefixIcon: IconAssets.mobileRun,
      isSelected: false.obs,
    ),
    ExerciserModel(
      description: "EXERCISER_ETC_DESCRIPTION",
      mainIcon: IconAssets.smartDevice,
      title: 'PHONE',
      topPrefixIcon: IconAssets.smartRun,
      isSelected: false.obs,
    ),
  ];

  static List<ConnectionModel> connectionModelList = <ConnectionModel>[
    ConnectionModel(
        bluetoothNumber: 'XOSS-3279488',
        bluetoothName: "SPEED".tr,
        topPrefixIcon: IconAssets.clock,
        isConnect: false.obs,
        networkIcon: IconAssets.greenNetwork),
    ConnectionModel(
        bluetoothNumber: 'XOSS-6946317',
        bluetoothName: "CADENCE".tr,
        topPrefixIcon: IconAssets.shoes,
        isConnect: false.obs,
        networkIcon: IconAssets.yellowNetwork),
  ];

  static List<AvailableDevicesModel> availableDevicesModelList =
      <AvailableDevicesModel>[
    AvailableDevicesModel(
        bluetoothNumber: 'XOSS-6946317',
        isConnect: false.obs,
        networkIcon: IconAssets.greenNetwork),
    AvailableDevicesModel(
        bluetoothNumber: 'cycplus S3 12458',
        isConnect: false.obs,
        networkIcon: IconAssets.yellowNetwork),
    AvailableDevicesModel(
        bluetoothNumber: 'cycplus S3 12458',
        isConnect: false.obs,
        networkIcon: IconAssets.unavailableNetwork),
  ];

  static List<ChoosePositionModel> positionModelList = [
    ChoosePositionModel(
      position: "WEARING_POSITION",
      positionDescription: "CHOOSE_THE_WEAR_POSITION_OF_YOUR_MOBILE_DEVICE",
      buttonName: 'CHOOSE',
      completeDes: '',
      completeButtonTitle: '',
      isSelected: false.obs,
      icChoose: false.obs,
    ),
    ChoosePositionModel(
      position: "BODY_INFO",
      positionDescription: 'NO_BODY_INFORMATION_YET',
      buttonName: "BODY_INFO",
      completeDes: '신체 정보를 등록해주세요',
      completeButtonTitle: 'EDIT',
      isSelected: isBodyInfoSelected,
      icChoose: false.obs,
    ),
    ChoosePositionModel(
      position: "STRIDE_TEST",
      positionDescription: "MEASURE_THE_MOVEMENT_VALUE_ALONG_THE_STRIDE_LENGTH",
      buttonName: 'STRIDE_TEST',
      completeDes: "TEST_COMPLETED_NORMALLY",
      completeButtonTitle: 'RETRY',
      isSelected: false.obs,
      icChoose: false.obs,
    ),
  ];
  static List<WearPosition> wearPositionModelList = <WearPosition>[
    WearPosition(
      position: "HAND",
      positionDescription: "HOLDING_THE_DEVICE_IN_YOUR_HAND",
      positionImage: ImageAssets.hand,
      isSelect: false,
    ),
    WearPosition(
      position: 'POCKET',
      positionDescription: "DEVICE_IN_YOUR_POCKET",
      positionImage: ImageAssets.pocket,
      isSelect: false,
    ),
    WearPosition(
      position: "ARM",
      positionDescription: "DEVICE_WITH_AN_ARMBAND",
      positionImage: ImageAssets.arm,
      isSelect: false,
    ),
  ];

  static String convertToAgo(String dateTime) {
    DateTime input =
        DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').parse(dateTime, true).toLocal();
    Duration diff = DateTime.now().toLocal().difference(input);
    if (diff.inDays > 365)
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "A_YEAR_AGO".tr : "A_YEAR_AGO".tr}";
    if (diff.inDays > 30)
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "MONTHS_AGO".tr : "MONTHS_AGO".tr}";
    if (diff.inDays > 7)
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "WEEKS_AGO".tr : "WEEKS_AGO".tr}";
    if (diff.inDays > 0)
      return "${diff.inDays} ${diff.inDays == 1 ? "DAYS_AGO".tr : "DAYS_AGO".tr}";
    if (diff.inHours > 0)
      return "${diff.inHours} ${diff.inHours == 1 ? "HOURS_AGO".tr : "HOURS_AGO".tr}";
    if (diff.inMinutes > 0)
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "MINUTES_AGO".tr : "MINUTES_AGO".tr}";
    return "just now";
    /* if (diff.inDays >= 1) {
      return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} second${diff.inSeconds == 1 ? '' : 's'} ago';
    } else {
      return 'just now';
    }*/
  }



  static String numberCounter(String? currentBalance) {
    try{
      // suffix = {' ', 'k', 'M', 'B', 'T', 'P', 'E'};
      int num = int.parse(currentBalance ?? '0');

      if (num > 999 && num < 99999) {
        return "${(num / 1000).toStringAsFixed(1)} K";
      } else if (num > 99999 && num < 999999) {
        return "${(num / 1000).toStringAsFixed(0)} K";
      } else if (num > 999999 && num < 999999999) {
        return "${(num / 1000000).toStringAsFixed(1)} M";
      } else if (num > 999999999) {
        return "${(num / 1000000000).toStringAsFixed(1)} B";
      } else {
        return num.toString();
      }
    }catch(e){
      print(e);
      return '0';
    }
  }


  static String removeAmPm(String time){

    bool isRemove=Constants.selectLanguageCode.toUpperCase()==Constants.korean ? true :false;
    if(isRemove) {
      time= time.replaceAll('AM', '');
      time= time.replaceAll('PM', '');
    }
    return time;
  }

  static closeKeyword(){
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
  }

  static String meterToKmConvert(dynamic meter) {
    double distanceInKiloMeters = double.parse(meter) / 1000;
    return distanceInKiloMeters.toStringAsFixed(2);
  }

  static String secondToMinit({required dynamic timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }


  static String secondToMinuteConvert({required dynamic timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "$min" : "$min";
    String second = sec.toString().length <= 1 ? "$sec" : "$sec";
    return "$minute.$second";
  }

  static String formatHHMMSS(dynamic totalMinute) {

    if (totalMinute != null && totalMinute != 0) {
      int seconds=totalMinute*60;
      int hours = (seconds / 3600).truncate();
      seconds = (seconds % 3600).truncate();
      int minutes = (seconds / 60).truncate();

      String hoursStr = (hours).toString().padLeft(2, '0');
      String minutesStr = (minutes).toString().padLeft(2, '0');

      if (hours == 0) {
        return "00:$minutesStr";
      }
      return "$hoursStr:$minutesStr";
    } else {
      return "0";
    }
  }


  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day+1);
    return (to.difference(from).inHours / 24).round();
  }
}
