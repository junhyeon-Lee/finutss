import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/presentation/screens/edit_body_info_screens/body_info_navigation.dart';
import 'package:finutss/presentation/screens/user_record_screens/body_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBodyInfoController extends GetxController {
  /* -------------------------------- variables ------------------------------- */
  final AuthController authController = Get.put(AuthController());

  bool isNavigatedFromEditBodyInfo = true;
  String? gender;
  RxBool male = false.obs;
  RxBool female = false.obs;
  String? selectedHeight = "160";
  String? selectedWeight = "60";
  String? selectedYearOfBirth = "1990";
  double bmi = 0;
  double scaleBmiValue = 0;
  double bmiSliderValue = 0;
  int screenIndex = 0;

  double bmiBarWidth = 0;
  RxBool isCompletedBodyInfo = false.obs;

  setBMIBarWidth(double value) {
    bmiBarWidth = (value - 20);
    update();
  }

/* ---------------------------------- lists --------------------------------- */
  List titleList = [
    'GENDER'.tr,
    'YEAR_OF_BIRTH'.tr,
    'HEIGHT'.tr,
    'WEIGHT'.tr,
    'BODY_INFO'.tr
  ];
  List textList = [
    'GENDER_INFO'.tr,
    'YEAR_OF_BIRTH_INFO'.tr,
    'HEIGHT_INFO'.tr,
    'WEIGHT_INFO'.tr,
    'INPUT_COMPLETION_GUIDE'.tr
  ];

  List<Map> weightRecordList = [
    {
      'backgroundColor': colorBackgroundSilver,
      'topText': '13',
      'midText': '50Kg',
      'bottomText': '12',
      'icon': Icons.arrow_drop_down,
      'bottomColor': Colors.green,
      'midColor': colorBlue
    },
    {
      'backgroundColor': colorBackgroundSilver,
      'topText': '11.25',
      'midText': '48Kg',
      'bottomText': '12',
      'icon': Icons.arrow_drop_up_outlined,
      'bottomColor': colorPink,
      'midColor': colorBlue
    },
    {
      'backgroundColor': colorBlue,
      'topText': '',
      'midText': '2022',
      'bottomText': '',
      'bottomColor': colorPink,
      'midColor': Colors.white
    },
    {
      'backgroundColor': colorBackgroundSilver,
      'topText': '13',
      'midText': '48Kg',
      'bottomText': '11',
      'icon': Icons.arrow_drop_up_outlined,
      'bottomColor': colorPink,
      'midColor': colorBlue
    },
    {
      'backgroundColor': colorBackgroundSilver,
      'topText': '13',
      'midText': '50Kg',
      'bottomText': '12',
      'icon': Icons.arrow_downward,
      'bottomColor': colorPink,
      'midColor': colorBlue
    },
    {
      'backgroundColor': colorBackgroundSilver,
      'topText': '11.25',
      'midText': '48Kg',
      'bottomText': '12',
      'icon': Icons.arrow_drop_up_outlined,
      'bottomColor': colorPink,
      'midColor': colorBlue
    },
    {
      'backgroundColor': colorBackgroundSilver,
      'topText': '13',
      'midText': '48Kg',
      'bottomText': '11',
      'icon': Icons.arrow_drop_up_outlined,
      'bottomColor': colorPink,
      'midColor': colorBlue
    }
  ];
  List addYearList = [
    2021,
    2020,
    2019,
    2018,
    2017,
    2016,
    2015,
    2014,
    2013,
    2012,
    2011,
    2010,
    2009,
    2008,
    2007,
    2006,
    2005,
    2004,
    2003,
    2002,
    2001,
    2000,
    1999,
    1998,
    1997,
    1996,
    1995,
    1994,
    1993,
    1992,
    1991,
    1990,
    1989,
    1988,
    1987,
    1986,
    1985,
    1984,
    1983,
    1982,
    1981,
    1980,
    1979,
    1978,
    1977,
    1976,
    1975,
    1974,
    1973,
    1972,
    1971,
    1970,
    1969,
    1968,
    1967,
    1966,
    1965,
    1964,
    1963,
    1962,
    1961,
    1960,
    1959,
    1958,
    1957,
    1956,
    1955,
    1954,
    1953,
    1952,
    1951,
    1950,
    1949,
    1948,
    1947,
    1946,
    1945,
    1943,
    1941,
    1939,
    1937,
    1935,
    1933,
    1930,
    1929,
    1928,
    1927,
    1926,
    1925,
    1924,
    1923,
    1922,
    1921,
    1920,
    1919,
    1918,
    1917,
    1916,
    1915,
    1914,
    1913,
    1912,
    1911,
    1910,
    1909,
    1909,
    1908,
    1907,
    1906,
    1905,
    1904,
    1903,
    1902,
    1901,
    1900,
  ];
  List addHeightList = [
    100,
    101,
    102,
    103,
    104,
    105,
    106,
    107,
    108,
    109,
    110,
    111,
    112,
    113,
    114,
    115,
    116,
    117,
    118,
    119,
    120,
    121,
    122,
    123,
    124,
    125,
    126,
    127,
    128,
    129,
    130,
    131,
    132,
    133,
    134,
    135,
    136,
    137,
    138,
    139,
    140,
    141,
    142,
    143,
    144,
    145,
    146,
    147,
    148,
    149,
    150,
    151,
    152,
    153,
    154,
    155,
    156,
    157,
    158,
    159,
    160,
    161,
    162,
    163,
    164,
    165,
    166,
    167,
    168,
    169,
    170,
    171,
    172,
    173,
    174,
    175,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    187,
    188,
    189,
    190,
    191,
    192,
    193,
    194,
    195,
    196,
    197,
    198,
    199,
    200,
    201,
    202,
    203,
    204,
    205,
    206,
    207,
    208,
    209,
    210,
    211,
    212,
    213,
    214,
    215,
    216,
    217,
    218,
    219,
    220,
    221,
    222,
    223,
    224,
    225,
    226,
    227,
    228,
    229,
    230,
    231,
    232,
    233,
    234,
    235,
    236,
    237,
    238,
    239,
    240,
    241,
    242,
    243,
    244,
    245,
    246,
    247,
    248,
    249,
    250,
  ];
  List addWeightList = [
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    40,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    50,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59,
    60,
    61,
    62,
    63,
    64,
    65,
    66,
    67,
    68,
    69,
    70,
    71,
    72,
    73,
    74,
    75,
    76,
    77,
    78,
    79,
    80,
    81,
    82,
    83,
    84,
    85,
    86,
    87,
    88,
    89,
    90,
    91,
    92,
    93,
    94,
    95,
    96,
    97,
    98,
    99,
    100,
    101,
    102,
    103,
    104,
    105,
    106,
    107,
    108,
    109,
    110,
    111,
    112,
    113,
    114,
    115,
    116,
    117,
    118,
    119,
    120,
    121,
    122,
    123,
    124,
    125,
    126,
    127,
    128,
    129,
    130,
    131,
    132,
    133,
    134,
    135,
    136,
    137,
    138,
    139,
    140,
    141,
    142,
    143,
    144,
    145,
    146,
    147,
    148,
    149,
    150,
    151,
    152,
    153,
    154,
    155,
    156,
    157,
    158,
    159,
    160,
    161,
    162,
    163,
    164,
    165,
    166,
    167,
    168,
    169,
    170,
    171,
    172,
    173,
    174,
    175,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    187,
    188,
    189,
    190,
    191,
    192,
    193,
    194,
    195,
    196,
    197,
    198,
    199,
    200,
    201,
    202,
    203,
    204,
    205,
    206,
    207,
    208,
    209,
    210,
    211,
    212,
    213,
    214,
    215,
    216,
    217,
    218,
    219,
    220,
    221,
    222,
    223,
    224,
    225,
    226,
    227,
    228,
    229,
    230,
    231,
    232,
    233,
    234,
    235,
    236,
    237,
    238,
    239,
    240,
    241,
    242,
    243,
    244,
    245,
    246,
    247,
    248,
    249,
    250,
    251,
    252,
    253,
    254,
    255,
    256,
    257,
    258,
    259,
    260,
    261,
    262,
    263,
    264,
    265,
    266,
    267,
    268,
    269,
    270,
    271,
    272,
    273,
    274,
    275,
    276,
    277,
    278,
    279,
    280,
    281,
    282,
    283,
    284,
    285,
    286,
    287,
    288,
    289,
    290,
    291,
    292,
    293,
    294,
    295,
    296,
    297,
    298,
    299,
    300,
  ];

/* -------------------------------- fuctions -------------------------------- */
  editGender(userId) {
    if (gender == null) {
      male.value = false;
      female.value = true;
      print('male $male');
      print('female $female');
    } else if (gender == 'male') {
      male.value = true;
      female.value = false;
      print('male $male');
      print('female $female');
    } else /*if(gender == 'Female')*/ {
      male.value = false;
      female.value = true;
      print('male $male');
      print('female $female');
    }
    update();
    print('male $male');
    print('female $female');
  }

  selectHeight(height) {
    selectedHeight = height;
    update();
  }

  selectWeight(weight) {
    selectedWeight = weight;
    update();
  }

  selectYearOfBirth(yearOfBirth) {
    selectedYearOfBirth = yearOfBirth;
    update();
  }

  calculateBMI() {
    bmi = (int.parse(selectedWeight!) /
            int.parse(selectedHeight!) /
            int.parse(selectedHeight!)) *
        10000;
    calculateBmiSliderValue();
    // bmiValue =
    print(bmi);
    update();
  }

  calculateBmiSliderValue() {
    scaleBmiValue = bmi - 15;
    bmiSliderValue = (scaleBmiValue * 250) / 25;
    print(bmiSliderValue);
    update();
  }

  onEditBodyInfoIconPressed() {
    isNavigatedFromEditBodyInfo = true;
    screenIndex = 0;
    if (screenIndex == 0) {
      gender = 'female';
      editGender(authController.user?.userId);
    }
    update();
    Get.to(() => BodyInfoNavigation());
  }

  onWeightEditButtonPressed() {
    isNavigatedFromEditBodyInfo = false;
    screenIndex = 3;
    update();
    Get.to(() => BodyInfoNavigation());
  }

  onNextButtonPressed() {
    screenIndex++;
    update();
  }

  onPrevButtonPressed() {
    if (screenIndex > 0) {
      screenIndex--;
    } else {
      screenIndex == 0;
      Get.back();
    }
    update();
  }

  onGenderPrevButtonPressed() {
    Get.off(() => BodyInfoScreen());
  }

  onRecordButtonPressed() {
    print("onRecordButtonPressed");
    authController.callApiUpdateUserInfo({
      "weight": int.parse(selectedWeight!),
    });
    Get.back();
  }

  onCancelButtonPressed() {
    Get.back();
  }

  onOKButtonPressed() {
    authController.callApiUpdateUserInfo({
      "sex": gender,
      "birthYear": new DateTime(int.parse(selectedYearOfBirth!)).toString(),
      "height": int.parse(selectedHeight!),
      "weight": int.parse(selectedWeight!),
    });
    print("index000000--->$screenIndex");
    isCompletedBodyInfo.value = true;
    screenIndex = 0;
    update();
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();

    ///TODO usersDetails
    /*
    if (authController.userBMI != null) bmi = authController.userBMI;
    if (authController.user != null) {
      if (authController.user?.usersDetails.height != null) {
        selectedHeight = authController.user?.usersDetails.height.toString();
      }
      if (authController.user?.usersDetails.weight != null) {
        selectedWeight = authController.user?.usersDetails.weight.toString();
      }
      if (authController.user?.usersDetails.sex != null) {
        gender = authController.user?.usersDetails.sex;
      }
      if (gender == "male") {
        female.value = false;
        male.value = true;
      }
      if (authController.user?.birthDate != null) {
        selectedYearOfBirth = authController.user!.birthDate!.year.toString();
      }
    }

     */

    // editGender();
  }
}
