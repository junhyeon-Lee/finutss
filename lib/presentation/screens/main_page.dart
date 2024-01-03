import 'package:finutss/constants.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/domain/bloc/main_bloc/main_bloc.dart';
import 'package:finutss/domain/bloc/main_bloc/main_event.dart';
import 'package:finutss/domain/bloc/main_bloc/main_state.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/black_list_controller.dart';
import 'package:finutss/domain/controller/event_controller.dart';
import 'package:finutss/domain/controller/f2f_controller.dart';
import 'package:finutss/domain/controller/follow_controller.dart';
import 'package:finutss/domain/controller/follower_controller.dart';
import 'package:finutss/domain/controller/home_controller.dart';
import 'package:finutss/domain/controller/hot_people_controller.dart';
import 'package:finutss/domain/controller/invite_friends_controller.dart';
import 'package:finutss/domain/controller/localization_service.dart';
import 'package:finutss/domain/controller/map_controller.dart';
import 'package:finutss/domain/controller/notice_controller.dart';
import 'package:finutss/domain/controller/notification_controller.dart';
import 'package:finutss/domain/controller/recommand_controller.dart';
import 'package:finutss/domain/controller/sensor_controller.dart';
import 'package:finutss/domain/controller/setting_controller.dart';
import 'package:finutss/domain/controller/tutorial_controller.dart';
import 'package:finutss/domain/controller/workout_in_controller.dart';
import 'package:finutss/domain/controller/workout_record_controller.dart';
import 'package:finutss/initPush.dart';
import 'package:finutss/presentation/animation/bouncing.dart';
import 'package:finutss/presentation/animation/scroll/ScrollBottomNavigationBar.dart';
import 'package:finutss/presentation/animation/scroll/ScrollBottomNavigationBarController.dart';
import 'package:finutss/presentation/screens/navigation_screens/track_record_screen.dart';
import 'package:finutss/presentation/screens/social_pages/find_friends.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/app_bar.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/notification_drawer.dart';
import 'package:finutss/presentation/widgets/dialogs/exit_app_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'navigation_screens/daily_track_screen.dart';
import 'navigation_screens/home_screen.dart';
import 'navigation_screens/social_screen.dart';
import 'setting_page/setting_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  final HomeController homeController = Get.put(HomeController());
  final AuthController authController = Get.put(AuthController());
  final MapController mapController = Get.put(MapController());
  final WorkoutRecordController workoutRecordController = Get.put(WorkoutRecordController());
  final RecommandController recommandController = Get.put(RecommandController());
  final HotPeopleController hotPeopleController = Get.put(HotPeopleController());
  final SensorController sensorController = Get.put(SensorController());
  final BlockListController blockListController = Get.put(BlockListController());
  final WorkoutInController workoutInController = Get.put(WorkoutInController());
  final FollowerController followerController = Get.put(FollowerController());
  final NoticeController noticeController = Get.put(NoticeController());
  final EventController eventController = Get.put(EventController());
  final NotificationController notificationController = Get.put(NotificationController());
  final F2FController f2fController = Get.put(F2FController());
  final InviteFriendsController inviteFriendsController = Get.put(InviteFriendsController());
  final FollowController followController = Get.put(FollowController());
  final TutorialController tutorialController = Get.put(TutorialController());
  final settingController = Get.put(SettingController(locale: Get.locale ?? LocalizationService.locales[0]));

  late MainBloc bloc;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  // ignore: unused_field

  /* -------------------------- navigation page lists ------------------------- */
  late List _tabPageList;

  @override
  void initState() {
    initCallApi();

    bloc = BlocProvider.of<MainBloc>(context);
    bloc.add(MainEventCheckTapButtonNavigationBarByIndex(index: homeController.bottomNavIndex));
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  _normalSizeButton({
    required Function onPressed,
    required double width,
    required IconData iconData,
    required int index,
    required int num,
    required double height,
  }) {
    return Bouncing(
      duration: Duration(milliseconds: 100),
      onPressed: onPressed as void Function()?,
      child: Container(
        width: width * 0.2,
        color: Color(0x44000000).withOpacity(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (index == num)
              Expanded(flex: 1, child: Container(color: height > 0.7 ? colorPink : Colors.transparent, width: 40)),
            Expanded(
              flex: 10,
              child: Container(
                width: width * 0.2,
                alignment: Alignment.center,
                child: Icon(iconData,
                    size: height < 0.6 ? 20 : height * 30, color: index == num ? colorPink : Color(0xffCDD5E9)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  initCallApi() async {
    var userAsguest = await LocalDB.getInt("userAsGuest");
    print("------userAsGuest---->>>${userAsguest}");
    homeController.callApiAds();
    PushHelp().init();

    ///TODO
    await mapController.callApiDailyTrack();
    await mapController.callApiTomorrowTrack();

    if (authController.user != null) {
      await workoutRecordController.callApiRecordDailyTotal(authController.user?.userId);
      await blockListController.callApiBlocks();
      await followController.callFollowPaginate(authController.user?.userId);
    }

    recommandController.callPaginateApi();
    hotPeopleController.callPaginateApi();

    ///TODO
    workoutInController.callPaginateApi();

    ///TODO
    f2fController.callFollowerPaginate(authController.user?.userId);
    await followerController.callFollowerPaginate(authController.user?.userId);

    await noticeController.callPaginateApi();
    await eventController.callPaginateApi();
    await inviteFriendsController.callApiInviteList();

    await notificationController;

    tutorialController.showTotorial(tutorialController.SensorIndex);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) => GetBuilder<HomeController>(builder: (controller) {
        return WillPopScope(
          onWillPop: () {
            Get.dialog(ExitAppDialog());
            return Future(() => false);
          },
          child: Scaffold(
            key: scaffoldKey,
            extendBody: true,
            appBar: homeController.bottomNavIndex == 2
                ? simpleAppBar(
                    text: 'SOCIAL'.tr,
                    automaticallyImplyLeading: false,
                    actions: <Widget>[
                      IconButton(
                          onPressed: () {
                            Get.to(() => FindFriends());
                          },
                          icon: Icon(
                            CupertinoIcons.search,
                            size: 24.r,
                            color: Color(0xFF3BCCE1),
                          ))
                    ],
                    visible: scrollController.bottomNavigationBar!.heightNotifier) as PreferredSizeWidget?
                : appbar(
                    key: scaffoldKey,
                    centerTitle: false,
                    visible: scrollController.bottomNavigationBar!.heightNotifier,
                    titleWidget: homeController.bottomNavIndex == 0
                        ? Image.asset(
                            'assets/images/logo.png',
                            height: 35.h,
                          )
                        : customText(
                            text: homeController.bottomNavIndex == 1
                                ? 'RECORD'.tr
                                : homeController.bottomNavIndex == 3
                                    ? 'SETTING'.tr
                                    : homeController.bottomNavIndex == 4
                                        ? 'TRACK'.tr
                                        : '',
                            fontColor: colorDarkGrey,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                  ) as PreferredSizeWidget?,
            endDrawer: SafeArea(
              child: ClipRRect(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.r), topLeft: Radius.circular(15.r)),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.transparent,
                  ),
                  child: Drawer(
                    elevation: 0,
                    child: NotificationDrawer(),
                  ),
                ),
              ),
            ),
            backgroundColor: getColor(state),
            body: SingleChildScrollView(
              physics: RangeMaintainingScrollPhysics(),
              controller: scrollController,
              child: getViewForIndex(state),
            ),
            floatingActionButton: ValueListenableBuilder(
              valueListenable: scrollController.bottomNavigationBar!.heightNotifier,
              builder: (BuildContext context, double height, Widget? child) {
                var distance;
                if (height < 1) {
                  distance = 1 - height;
                  print(distance);
                }
                return Transform.translate(
                  offset: Offset(0, height < 1 ? distance * 18 : 0),
                  child: Bouncing(
                    // scaleFactor: 2.5,
                    duration: Duration(milliseconds: 100),
                    onPressed: () {
                      homeController.bottomNavIndex = 4;
                      bloc.add(MainEventCheckTapButtonNavigationBarByIndex(index: homeController.bottomNavIndex));
                      tutorialController.showTotorial(tutorialController.RecordIndex);
                    },
                    child: Container(
                      height: height < 0.5 ? 25 : height * 50,
                      width: height < 0.5 ? 25 : height * 50,
                      alignment: Alignment.center,
                      decoration: height > 0.5
                          ? BoxDecoration(
                              color: state is MainStateRunDailyTrackScreen ? colorPink : colorBlue,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 0), // changes position of shadow
                                ),
                              ],
                            )
                          : BoxDecoration(
                              color: state is MainStateRunDailyTrackScreen ? colorPink : Color(0xffCDD5E9),
                              shape: BoxShape.circle,
                            ),
                      child: Icon(
                        Icons.play_arrow,
                        size: height < 0.5 ? 15 : height * 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: ValueListenableBuilder(
              valueListenable: scrollController.bottomNavigationBar!.heightNotifier,
              builder: (context, double height, child) {
                return ScrollBottomNavigationBar(
                  notchMargin: height < 1 ? height : height * 4.0,
                  fixedColor: height > 0.5 ? Colors.white : Colors.transparent,
                  shape: height > 0.5 ? CircularNotchedRectangle() : null,
                  clipBehavior: Clip.antiAlias,
                  elevation: height > 0.5 ? height * 4 : 0,
                  controller: scrollController,
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        _normalSizeButton(
                          height: height,
                          onPressed: () {
                            homeController.bottomNavIndex = 0;
                            bloc.add(MainEventCheckTapButtonNavigationBarByIndex(index: homeController.bottomNavIndex));
                          },
                          width: width,
                          iconData: iconList[0],
                          index: homeController.bottomNavIndex,
                          num: 0,
                        ),
                        _normalSizeButton(
                          height: height,
                          onPressed: () {
                            homeController.bottomNavIndex = 1;
                            bloc.add(MainEventCheckTapButtonNavigationBarByIndex(index: homeController.bottomNavIndex));
                          },
                          width: width,
                          iconData: iconList[1],
                          index: homeController.bottomNavIndex,
                          num: 1,
                        ),
                        InkWell(
                          onTap: () {
                            homeController.bottomNavIndex = 4;
                            bloc.add(MainEventCheckTapButtonNavigationBarByIndex(index: homeController.bottomNavIndex));
                          },
                          child: Container(
                            width: width * 0.2,
                          ),
                        ),
                        _normalSizeButton(
                          height: height,
                          onPressed: () {
                            homeController.bottomNavIndex = 2;
                            bloc.add(MainEventCheckTapButtonNavigationBarByIndex(index: homeController.bottomNavIndex));
                          },
                          width: width,
                          iconData: iconList[2],
                          index: homeController.bottomNavIndex,
                          num: 2,
                        ),
                        _normalSizeButton(
                          height: height,
                          onPressed: () {
                            homeController.bottomNavIndex = 3;
                            bloc.add(MainEventCheckTapButtonNavigationBarByIndex(index: homeController.bottomNavIndex));
                          },
                          width: width,
                          iconData: iconList[3],
                          index: homeController.bottomNavIndex,
                          num: 3,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }

  Widget getViewForIndex(MainState state) {
    if (state is MainStateRunHomeScreen) {
      return HomeScreen(scrollController: scrollController);
    } else if (state is MainStateRunTrackRecordScreen) {
      return TrackRecordScreen(scrollController: scrollController);
    } else if (state is MainStateRunSocialScreen) {
      return SocialScreen(scrollController: scrollController);
    } else if (state is MainStateRunSettingPage) {
      return SettingPage(scrollController: scrollController);
    } else if (state is MainStateRunDailyTrackScreen) {
      return DailyTrackScreen(scrollController: scrollController);
    } else {
      return HomeScreen(scrollController: scrollController);
    }
  }

  Color getColor(MainState state) {
    if (state is MainStateRunHomeScreen) {
      return Color(0xffF5F7FA);
    } else if (state is MainStateRunTrackRecordScreen) {
      return colorBackgroundSilver;
    } else if (state is MainStateRunSocialScreen) {
      return Color(0xFFF5F7FA);
    } else if (state is MainStateRunSettingPage) {
      return colorBackgroundSilver;
    } else if (state is MainStateRunDailyTrackScreen) {
      return colorBackgroundSilver;
    } else {
      return Colors.white;
    }
  }

  final iconList = <IconData>[Icons.home, Icons.note_alt_rounded, Icons.message, Icons.dashboard];
}
