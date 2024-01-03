import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'localization_service.dart';

class SettingController extends GetxController {
  RxBool isChecked = false.obs;
  var jsonTerm;

  SettingController({Locale? locale}) {
    if (locale != null)
      selectedValue = LocalizationService.getLanguageFromLocale(locale);
    // callApiTerms();
  }

  String selectedValue = "English (US)";

  /* -------------------------------- functions ------------------------------- */
  // unSelectAllLanguage() {
  //   for (var data in languageList) {
  //     data['isSelected'] = false;
  //   }
  // }

  /* ---------------------------------- lists --------------------------------- */
  // List languageList = [
  //   {'language': 'English (US)', 'isSelected': true},
  //   {'language': 'English (UK)', 'isSelected': false},
  //   {'language': 'Spanish ', 'isSelected': false},
  //   {'language': 'Turkish ', 'isSelected': false},
  //   {'language': 'Chines ', 'isSelected': false},
  //   {'language': 'Urdu اُردُو', 'isSelected': false},
  //   {'language': 'Hindi', 'isSelected': false},
  //   {'language': 'Swedish', 'isSelected': false},
  // ];

  List appPermissionsList = [
    {'title': 'Location', 'value': true},
    {'title': 'Storage', 'value': false},
    {'title': 'Phone', 'value': true},
    {'title': 'Contact', 'value': true},
  ];
  List pushNotificationList = [
    {'title': 'ALL'.tr, 'value': true, "name": "all"},
    {'title': 'APP_SYSTEMS'.tr, 'value': false, "name": "alertSystem"},
    {'title': 'WORKOUT_ROUTINE'.tr, 'value': true, "name": "alertWorkout"},
    {'title': 'FOLLOWING'.tr, 'value': false, "name": "alertFollowing"},
    {'title': 'INVITE_WORKOUT'.tr, 'value': true, "name": "alertInvite"},
    {'title': 'DO_NOT_DISTURB'.tr, 'value': true, "name": "alertDoNotDisturb"},
  ];
  List noticeList = [
    {
      'type': '[Notice]',
      'notice': 'Notice of partial chapter or etc',
      'date': '2021.11.21'
    },
    {
      'type': '[Notice] ',
      'notice': 'Member subscription...',
      'date': '2021.11.21'
    },
    {'type': '[Update]', 'notice': '''1 100 vs’ Open''', 'date': '2021.11.21'},
    {
      'type': '[Notice]',
      'notice': 'Kakao Pay Payment S...',
      'date': '2021.11.21'
    },
    {
      'type': '[Update]',
      'notice': 'Support Workout De...',
      'date': '2021.11.21'
    },
    {
      'type': '[Update]',
      'notice': '''Laboratory 'Audio Qu...''',
      'date': '2021.11.21'
    },
    {'type': '', 'notice': '[Notice] Service Inspection', 'date': '2021.11.21'},
  ];
  List inquiryList = [
    {
      'type': '[Payment]',
      'title': 'Card Payment',
      'date': '2021.11.21',
      'status': 'WAITING'.tr
    },
    {
      'type': '[Announcement] ',
      'title': 'Who could it be?',
      'date': '2021.11.21',
      'status': 'COTACT_US_COMPLETE'.tr
    },
    {
      'type': '[Payment]',
      'date': '2021.11.21',
      'title': '''CardPayment''',
      'status': 'COTACT_US_COMPLETE'.tr
    },
    {
      'type': '[Event]',
      'title': 'Sharing Events',
      'date': '2021.11.21',
      'status': 'COTACT_US_COMPLETE'.tr
    },
    {
      'type': '[Payment]',
      'title': 'Card Payment',
      'date': '2021.11.21',
      'status': 'COTACT_US_COMPLETE'.tr
    },
  ];
  List eventList = [
    {'type': '[Event]', 'event': 'Sharing Events', 'date': '2021.11.21'},
    {'type': '[Announce]', 'event': 'Who could it be?', 'date': '2021.11.21'},
    {'type': '[Event]', 'event': '''Who could it be?''', 'date': '2021.11.21'},
    {'type': '[Event]', 'event': 'Sharing Events', 'date': '2021.11.21'},
    {'type': '[Event] ', 'event': 'Sharing Events', 'date': '2021.11.21'},
    {'type': '[Event]', 'event': ''' Sharing Events''', 'date': '2021.11.21'},
    {'type': '[Event] ', 'event': 'Sharing Events', 'date': '2021.11.21'},
  ];
  static List contactUsList = [
    ['ABOUT_PAYMENT'.tr, "Payment"],
    ['HISTORY_SYSTEM'.tr, "History System"],
    ['BUG_REPORTING'.tr, "Bug Reporting"],
    ['OTHER'.tr, "Other"],
  ];

  static List statusList = [
    ['WAITING'.tr, "WAITING"],
    ['COTACT_US_COMPLETE'.tr, "COMPLETE"],
  ];

  List contactUsRules = [
    "CONTACT_US_INFO".tr,
  ];

  callApiTerms() async {
    try {
      print("-callUserInfoApi");
      String dataString =
          await rootBundle.loadString('assets/privacy/privacy_policy.json');
      Map langDynamic = jsonDecode(dataString);
      var userInfo = langDynamic;
      jsonTerm = userInfo;
      update();
    } catch (e, stacktrace) {
      print('Exception: ' + e.toString());
      print('Stacktrace: ' + stacktrace.toString());
    }
  }
}
