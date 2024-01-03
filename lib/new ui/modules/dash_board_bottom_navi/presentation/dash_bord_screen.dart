import 'dart:io';

import 'package:finutss/new%20ui/controller/login_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/controller/black_list_controller.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/connection_connect_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/dash_board_bottom_navi/controller/dashboard_screen_controller.dart';
import 'package:finutss/new%20ui/modules/dash_board_bottom_navi/widget/bnb_custom_painter.dart';
import 'package:finutss/new%20ui/modules/home/controller/notification_controller.dart';
import 'package:finutss/new%20ui/modules/home/presentation/home_sensor_states_screen.dart';
import 'package:finutss/new%20ui/modules/home/widget/notification_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/record/controller/record_controller.dart';
import 'package:finutss/new%20ui/modules/record/presentation/record_screen.dart';
import 'package:finutss/new%20ui/modules/setting/presentation/setting_screen.dart';
import 'package:finutss/new%20ui/modules/social/controller/social_controller.dart';
import 'package:finutss/new%20ui/modules/social/presentation/social_screen.dart';
import 'package:finutss/new%20ui/modules/track/presentation/track_screeen.dart';
import 'package:finutss/new%20ui/modules/user_profile/controller/controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/custom_navigator.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:finutss/new%20ui/widget/notice_dialog.dart';
import 'package:finutss/new%20ui/widget/sensor_appbar.dart';
import 'package:finutss/presentation/animation/bouncing.dart';
import 'package:finutss/presentation/animation/scroll/ScrollBottomNavigationBarController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class   DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  DashboardController bottomNavigationBarController =
      Get.put(DashboardController());
  final GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();
  LoginController loginController = Get.find();
  ScrollController scrollController = ScrollController();
  bool _isVisible = true;
  AppSettingController settingController = Get.find();
  BlackListController blackListController = Get.find();
  HomeNotificationController homeNotificationController =
      Get.put(HomeNotificationController());
  RecordController recordController=Get.put(RecordController());
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  )..forward();

  final SocialController controller2 = Get.put(SocialController());
  final userProfileController controller1 = Get.put(userProfileController());


  List<Widget> buildScreens() {
    return [
      HomeSensorStatesScreen(
        scrollController: scrollController,
      ),
      RecordScreen(
        scrollController: scrollController,
      ),
      TrackScreen(
        scrollController: scrollController,
      ),
      SocialScreen(
        scrollController: scrollController,
      ),
      SettingScreen(
        scrollController: scrollController,
      ),
    ];
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Constants.isLogin=true;
      if (!Constants.isGuest) {
        blackListController.getBlackListLength().then((value) {
          settingController.getCurrentUser();
          settingController.getWallet().then((value) {
            settingController.getWalletTransaction();
          });
        });
      } else {
        blackListController.blackListTotalLength.value = 0;
      }
    });
    _isVisible = true;
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (scrollController.position.minScrollExtent > 50) {
          _controller.reverse();
          setState(() {
            _isVisible = true;
          });
        }
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (scrollController.position.maxScrollExtent < 300) {
          _controller.forward();
          setState(() {
            _isVisible = true;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColor.backGroundColor,
      ),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: ()async{
            appExitBottomSheet(context);
            return false;
          },
          child: Scaffold(
            backgroundColor: AppColor.backGroundColor,
            body: Container(
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Column(
                      children: [
                        Obx(
                          () {
                            return SensorAppBar(
                              sensorOnTap: () {
                                connectionConnectBottomSheet(context);
                              },
                              notificationOnTap: () async {
                                if (!Constants.isGuest) {
                                  if (bottomNavigationBarController
                                          .currentIndex.value ==
                                      3) {
                                    Navigation.pushNamed(
                                        Routes.findFriendsScreen);
                                  }
                                  else {
                                    Navigator.of(context).push(
                                      PageRouteBuilder(
                                        opaque: false,
                                        pageBuilder:
                                            (BuildContext context, _,
                                            __) =>
                                                NotificationScreen(),
                                      ),
                                    );
                                  }
                                } else {
                                  GuestNotice(context);
                                }
                              },
                              leftIconPath: bottomNavigationBarController
                                          .currentIndex.value !=
                                      3
                                  ? getCurrentType()
                                  : '',
                              rightIconPath: bottomNavigationBarController
                                  .appBarList[bottomNavigationBarController
                                      .currentIndex.value]
                                  .rightIconPath,
                              title: bottomNavigationBarController
                                  .appBarList[bottomNavigationBarController
                                      .currentIndex.value]
                                  .title,
                            );
                          },
                        ),
                        Expanded(
                          child: Obx(
                            () => CustomNavigator(
                              navigatorKey: _key,
                              home: buildScreens()[bottomNavigationBarController
                                  .currentIndex.value],
                              pageRoute: PageRoutes.materialPageRoute,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: ValueListenableBuilder(
                      valueListenable:
                          scrollController.bottomNavigationBar?.heightNotifier ??
                              ValueNotifier(0.0),
                      builder:
                          (BuildContext context, double height, Widget? child) {
                        double bottomHeight = height < 0.76 ? 50 : height * 80;
                        return AnimatedScale(
                          duration: const Duration(milliseconds: 1000),
                          scale: _isVisible ? 1 : 0.0,
                          curve: Curves.easeIn,
                          key: _isVisible ? Key("round") : Key("stright"),
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: size.width,
                            height: bottomHeight,
                            color:
                                height < 0.5 ? Colors.white : Colors.transparent,
                            child: Stack(
                              children: [
                                height < 0.5
                                    ? Container()
                                    : CustomPaint(
                                        size: Size(size.width, 80),
                                        painter: BNBCustomPainter(),
                                      ),
                                height < 0.2
                                    ? Container()
                                    : _middleButton(
                                        onTap: () async {
                                          Constants.isGuest == true
                                              ? GuestNotice(context)
                                              : bottomNavigationBarController
                                                  .setBottomBarIndex(2);
                                        },
                                        isSmallIC: false,
                                        index: 2,
                                        imagePath: IconAssets.play,
                                        height: height),
                                Container(
                                  width: size.width,
                                  height: bottomHeight,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _menuWidget(
                                        onTap: () {
                                          bottomNavigationBarController
                                              .setBottomBarIndex(0);
                                        },
                                        index: 0,
                                        imagePath: IconAssets.home,
                                        height: height,
                                      ),
                                      _menuWidget(
                                        onTap: () {
                                          bottomNavigationBarController
                                              .setBottomBarIndex(1);
                                        },
                                        index: 1,
                                        imagePath: IconAssets.activity,
                                        height: height,
                                      ),
                                      Bouncing(
                                        duration: Duration(milliseconds: 400),
                                        onPressed: () {
                                          bottomNavigationBarController
                                              .setBottomBarIndex(2);
                                        },
                                        child: height < 0.4
                                            ? _middleButton(
                                                onTap: () {
                                                  Constants.isGuest == true
                                                      ? GuestNotice(context)
                                                      : bottomNavigationBarController
                                                          .setBottomBarIndex(2);
                                                },
                                                index: 2,
                                                isSmallIC: true,
                                                imagePath: IconAssets.play,
                                                height: height)
                                            : Container(
                                                width: 60.w,
                                              ),
                                      ),
                                      _menuWidget(
                                        onTap: () {
                                          bottomNavigationBarController
                                              .setBottomBarIndex(3);
                                        },
                                        index: 3,
                                        imagePath: IconAssets.chat,
                                        height: height,
                                      ),
                                      _menuWidget(
                                        onTap: () {
                                          bottomNavigationBarController
                                              .setBottomBarIndex(4);
                                        },
                                        index: 4,
                                        imagePath: IconAssets.category,
                                        height: height,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getCurrentType() {
    if (bottomNavigationBarController.currentIndex.value != 3) {
      String workoutType = loginController.getCurrentType();
      return workoutType;
    } else {
      return '';
    }
  }

  Widget _menuWidget(
      {VoidCallback? onTap,
      required int index,
      required String imagePath,
      required double height}) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              scale: 4,
              color: bottomNavigationBarController.currentIndex == index
                  ? Colors.orange
                  : AppColor.grayColor,
            ),
            height > 0.1
                ? Column(
                    children: [
                      SizedBox(
                        height: height * 5.h,
                      ),
                      CircleAvatar(
                        backgroundColor:
                            bottomNavigationBarController.currentIndex == index
                                ? AppColor.orangeColor
                                : Colors.transparent,
                        radius: 3,
                      )
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _middleButton(
      {VoidCallback? onTap,
      required int index,
      required bool isSmallIC,
      required String imagePath,
      required double height}) {
    var distance;
    if (height < 1) {
      distance = 1 - height;
      print(distance);
    }

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isSmallIC
              ? Obx(() => SvgPicture.asset(
                  bottomNavigationBarController.currentIndex == index
                      ? IconAssets.playSelectIcon
                      : IconAssets.playIcon))
              : Column(
                  children: [
                    Transform.translate(
                      offset: Offset(0, height < 1 ? distance * 30 : 0),
                      child: Bouncing(
                        duration: Duration(milliseconds: 100),
                        onPressed: onTap,
                        child: Center(
                          heightFactor: 0.6,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // color: Colors.blue,
                              gradient: LinearGradient(
                                colors: [
                                  AppColor.orangeGradiant1,
                                  AppColor.orangeGradiant2,
                                ],
                              ),
                            ),
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: height * 50.h,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

          /* isSmallIC
              ? CircleAvatar(
                  backgroundColor:
                      bottomNavigationBarController.currentIndex == index
                          ? AppColor.orangeColor
                          : Colors.transparent,
                  radius: 3,
                )
              : SizedBox(
          ),*/
        ],
      ),
    );
  }
}

Future<void> appExitBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    enableDrag: false,
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.black.withOpacity(0.2),
    builder: (context) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        height: MediaQuery.of(context).size.height * 2,
        width: MediaQuery.of(context).size.width,
        child: SizedBox(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigation.pop();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 12.w),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            IconAssets.close,
                            scale: 4,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.elliptical(
                                MediaQuery.of(context).size.width,
                                100.0,
                              ),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 26.h,
                                ),
                                Text(
                                  "EXIT".tr.toUpperCase(),
                                  style: TextStyle(
                                    color: AppColor.subTitleColor,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 19.h,
                                ),
                                Text(
                                  'DO_YOU_WANT_TO_SHUT_DOWN_THE_FINUTSS_APP'.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColor.subTitleColor
                                        .withOpacity(0.8),
                                    fontSize: 14.sp,
                                    height: 1.63,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                SizedBox(
                                  height: 36.h,
                                ),
                                CancelSaveButton(
                                  cancelTitle: 'CANCEL'.tr.toUpperCase(),
                                  saveTitle: "EXIT".tr,
                                  onTapCancel: (){
                                    Navigation.pop();
                                  },
                                  onTapSave: () async {
                                    if (Platform.isIOS) {
                                      exit(0);
                                    } else {
                                      SystemNavigator.pop();
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 50.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}