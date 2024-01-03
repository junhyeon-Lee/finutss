// import 'dart:io';
// import 'dart:math' as math;
// import 'dart:ui' as ui;
//
// import 'package:flutter/material.dart';
//
// class SizeUtils {
//   static late MediaQueryData _mediaQueryData;
//   static late double screenWidth;
//   static late double screenHeight;
//   static late double horizontalBlockSize;
//   static late double verticalBlockSize;
//   static late double appBarHeight;
//
//   void init(BuildContext context) {
//     _mediaQueryData = MediaQuery.of(context);
//     screenWidth = _mediaQueryData.size.width;
//     screenHeight = _mediaQueryData.size.height;
//     // horizontalBlockSize = screenWidth / 150;
//     horizontalBlockSize = screenWidth / (isTablet() ? 150 : 100);
//
//     // verticalBlockSize = screenHeight / 150;
//     verticalBlockSize = screenHeight / (100);
//     appBarHeight = AppBar().preferredSize.height;
//   }
//
//   static bool isTablet() => false;
//
//   static bool isPhone() => Device.get().isPhone;
//
//   static bool isIphoneX() => Device.get().isIphoneX;
//
//   static fSize_385() {
//     return horizontalBlockSize * 106.953; //385
//   }
//
//   static fSize_300() {
//     return horizontalBlockSize * 86; //300
//   }
//
//   static fSize_275() {
//     return horizontalBlockSize * 75; //250
//   }
//
//   static fSize_250() {
//     return horizontalBlockSize * 69.45; //250
//   }
//
//   static fSize_200() {
//     return horizontalBlockSize * 57; //200
//   }
//
//   static fSize_140() {
//     return horizontalBlockSize * 38; //150
//   }
//
//   static fSize_150() {
//     return horizontalBlockSize * 43; //150
//   }
//
//   static fSize_120() {
//     return horizontalBlockSize * 33.344; //120
//   }
//
//   static fSize_110() {
//     return horizontalBlockSize * 30.562; //110
//   }
//
//   static fSize_100() {
//     return horizontalBlockSize * 27.78; //100
//   }
//
//   static fSize_90() {
//     return horizontalBlockSize * 25.008; //90
//   }
//
//   static fSize_82() {
//     return horizontalBlockSize * 22.4; //82
//   }
//
//   static fSize_80() {
//     return horizontalBlockSize * 20.514; //80
//   }
//
//   static fSize_75() {
//     return horizontalBlockSize * 20.85; //75
//   }
//
//   static fSize_70() {
//     return horizontalBlockSize * 19; //70
//   }
//
//   static fSize_60() {
//     return horizontalBlockSize * 16.672; //60
//   }
//
//   static fSize_55() {
//     return horizontalBlockSize * 15.281; //55
//   }
//
//   static fSize_50() {
//     return horizontalBlockSize * 13.89; //50
//   }
//
//   static fSize_48() {
//     return horizontalBlockSize * 13.38; //48
//   }
//
//   static fSize_45() {
//     return horizontalBlockSize * 12.51; //45
//   }
//
//   static fSize_40() {
//     return horizontalBlockSize * 10.257; //40
//   }
//
//   static fSize_38() {
//     return horizontalBlockSize * 11; //38
//   }
//
//   static fSize_34() {
//     return horizontalBlockSize * 9.5; //34
//   }
//
//   static fSize_30() {
//     return horizontalBlockSize * 8.336; //30
//   }
//
//   static double fSize_35() {
//     return horizontalBlockSize * 9.750; //35
//   }
//
//   static double fSize_36() {
//     return horizontalBlockSize * 9.995; //36
//   }
//
//   static fSize_28() {
//     return horizontalBlockSize * 7; //28
//   }
//
//   static fSize_25() {
//     return horizontalBlockSize * 6.945; //25
//   }
//
//   static fSize_24() {
//     return horizontalBlockSize * 6.690; //24
//   }
//
//   static fSize_22() {
//     return horizontalBlockSize * 6.0; //20
//   }
//
//   static fSize_20() {
//     return horizontalBlockSize * 5.560; //20
//   }
//
//   static fSize_18() {
//     return horizontalBlockSize * 5.0; //18
//   }
//
//   static fSize_17() {
//     return horizontalBlockSize * 4.75; //18
//   }
//
//   static fSize_16() {
//     return horizontalBlockSize * 4.450; //16
//   }
//
//   static fSize_15() {
//     return horizontalBlockSize * 4.170; //15
//   }
//
//   static fSize_14() {
//     return horizontalBlockSize * 3.900; //14
//   }
//
//   static fSize_11() {
//     return horizontalBlockSize * 3.06; //11
//   }
//
//   static fSize_12() {
//     return horizontalBlockSize * 3.360; //12
//   }
//
//   static fSize_13() {
//     return horizontalBlockSize * 3.637; //13
//   }
//
//   static fSize_10() {
//     return horizontalBlockSize * 2.800; //10
//   }
//
//   static fSize_9() {
//     return horizontalBlockSize * 2.595; //8
//   }
//
//   static fSize_8() {
//     return horizontalBlockSize * 2.245; //8
//   }
//
//   static fSize_6() {
//     return horizontalBlockSize * 1.685; //6
//   }
//
//   static fSize_4() {
//     return horizontalBlockSize * 1.120; //4
//   }
//
//   static fSize_3() {
//     return horizontalBlockSize * 0.8425; //6
//   }
//
//   static fSize_2() {
//     return horizontalBlockSize * 0.560; //4
//   }
// }
//
// class Device {
//   static double devicePixelRatio = ui.window.devicePixelRatio;
//   static ui.Size size = ui.window.physicalSize;
//   static double width = size.width;
//   static double height = size.height;
//   static double screenWidth = width / devicePixelRatio;
//   static double screenHeight = height / devicePixelRatio;
//   static ui.Size screenSize = ui.Size(screenWidth, screenHeight);
//   final bool isTablet, isPhone, isIos, isAndroid, isIphoneX, hasNotch;
//   static Device? _device;
//   static VoidCallback? onMetricsChange;
//
//   Device({
//     required this.isTablet,
//     required this.isPhone,
//     required this.isIos,
//     required this.isAndroid,
//     required this.isIphoneX,
//     required this.hasNotch,
//   });
//
//   factory Device.get() {
//     if (_device != null) return _device!;
//
//     if (onMetricsChange == null) {
//       onMetricsChange = ui.window.onMetricsChanged;
//       ui.window.onMetricsChanged = () {
//         _device = null;
//
//         size = ui.window.physicalSize;
//         width = size.width;
//         height = size.height;
//         screenWidth = width / devicePixelRatio;
//         screenHeight = height / devicePixelRatio;
//         screenSize = ui.Size(screenWidth, screenHeight);
//
//         onMetricsChange!();
//       };
//     }
//
//     bool isTablet;
//     bool isPhone;
//     final isIos = Platform.isIOS;
//     final isAndroid = Platform.isAndroid;
//     var isIphoneX = false;
//     var hasNotch = false;
//     if (devicePixelRatio < 2 && (width >= 600)) {
//       isTablet = true;
//       isPhone = false;
//     } else if (devicePixelRatio == 2 && (width >= 600 && width <= 1600)) {
//       isTablet = true;
//       isPhone = false;
//     } else {
//       isTablet = false;
//       isPhone = true;
//     }
//
//     // Recalculate for Android Tablet using device inches
//     if (isAndroid) {
//       final adjustedWidth = _calWidth() / devicePixelRatio;
//       final adjustedHeight = _calHeight() / devicePixelRatio;
//       final diagonalSizeInches = (math.sqrt(math.pow(adjustedWidth, 2) + math.pow(adjustedHeight, 2))) / _ppi;
//
//       if (diagonalSizeInches >= 7) {
//         isTablet = true;
//         isPhone = false;
//       } else {
//         isTablet = false;
//         isPhone = true;
//       }
//     }
//
//     if (isIos &&
//         isPhone &&
//         (screenHeight == 812 ||
//             screenWidth == 812 ||
//             screenHeight == 896 ||
//             screenWidth == 896 ||
//             // iPhone 12 pro
//             screenHeight == 844 ||
//             screenWidth == 844 ||
//             // Iphone 12 pro max
//             screenHeight == 926 ||
//             screenWidth == 926)) {
//       isIphoneX = true;
//       hasNotch = true;
//     }
//
//     if (_hasTopOrBottomPadding()) hasNotch = true;
//
//     return _device = Device(
//       isTablet: isTablet,
//       isPhone: isPhone,
//       isAndroid: isAndroid,
//       isIos: isIos,
//       isIphoneX: isIphoneX,
//       hasNotch: hasNotch,
//     );
//   }
//
//   static double _calWidth() {
//     if (width > height) {
//       return (width + (ui.window.viewPadding.left + ui.window.viewPadding.right) * width / height);
//     }
//     return (width + ui.window.viewPadding.left + ui.window.viewPadding.right);
//   }
//
//   static double _calHeight() {
//     return (height + (ui.window.viewPadding.top + ui.window.viewPadding.bottom));
//   }
//
//   static int get _ppi => Platform.isAndroid
//       ? 160
//       : Platform.isIOS
//           ? 150
//           : 96;
//
//   static bool _hasTopOrBottomPadding() {
//     final padding = ui.window.viewPadding;
//     return padding.top > 0 || padding.bottom > 0;
//   }
// }
