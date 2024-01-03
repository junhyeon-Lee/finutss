import 'package:finutss/new%20ui/modules/channel_track/controller/channel_controller.dart';
import 'package:finutss/new%20ui/modules/channel_track/presentation/letest_tracks_tab.dart';
import 'package:finutss/new%20ui/modules/channel_track/presentation/popular_tracks_tab.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/widget/channel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class ChannelTrackScreen extends StatefulWidget {
  ChannelTrackScreen({Key? key,required this.channelId}) : super(key: key);

  String channelId;

  @override
  State<ChannelTrackScreen> createState() => _ChannelTrackSCreenState();
}

class _ChannelTrackSCreenState extends State<ChannelTrackScreen> with SingleTickerProviderStateMixin {
  ScrollController? _scrollController;
  bool lastStatus = true;
  double height = 200;
  late TabController _tabController;
  late ChannelController trackController;





  @override
  void initState() {
    super.initState();
    trackController = Get.put(ChannelController(),tag: widget.channelId);
    _scrollController = ScrollController()..addListener(_scrollListener);
    _tabController = TabController(length: 2, vsync: this);
    trackController.currentChannelId=widget.channelId;

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
          trackController.clearList();
          trackController.getChannelInfo().then((value) {
            trackController.getPopularTrack().then((value) {
              trackController.getLatestTrack();
            });
          });
        });
  }


  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (400 * 40 - kToolbarHeight);
  }


  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              ChannelAppBar(
                extent: 260.h,
                trackController: trackController,
                avatar: Container(),
                title: "Test AppBar",
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: FloatingHeader(
                  Container(
                    height: 38.h,
                    color: AppColor.whiteColor,
                    child: TabBar(
                      isScrollable: false,
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: AppColor.orangeColor,
                      indicatorColor: AppColor.orangeColor,
                      unselectedLabelColor: AppColor.grayColor,
                      indicatorPadding: EdgeInsets.symmetric(vertical: 0),
                      labelPadding: EdgeInsets.symmetric(horizontal: 25),
                      indicator: MaterialIndicator(
                          color: AppColor.orangeColor,
                          paintingStyle: PaintingStyle.fill,
                          tabPosition: TabPosition.bottom,
                          horizontalPadding: 22.w),
                      labelStyle: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      tabs: [
                        Text(
                          'POPULAR_TRACKS'.tr,
                        ),
                        Text(
                          'LATEST_TRACKS'.tr,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(controller: _tabController, children: [
            PopularTracksTab(controller: trackController,),
            LatestTracksTab(controller: trackController,),
          ]),
        ),
      ),
    );
  }
}

class FloatingHeader extends SliverPersistentHeaderDelegate {
  FloatingHeader(this.tabBar);

  Container tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return tabBar;
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  double get maxExtent => 38.h;

  @override
  double get minExtent => 38.h;
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  MySliverPersistentHeaderDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height + 5;

  @override
  double get maxExtent => _tabBar.preferredSize.height + 5;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColor.whiteColor,
      height: 42.h,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(MySliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
