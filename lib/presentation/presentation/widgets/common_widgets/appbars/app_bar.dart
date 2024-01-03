import 'package:finutss/constants.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/presentation/widgets/dialogs/sensor_dialogs/connection_dialog_combined.dart';
import 'package:finutss/presentation/widgets/dialogs/track_distance_dialogs/exit_workout_dialog.dart';
import 'package:finutss/presentation/widgets/user_notic_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget appbar(
    {required Widget titleWidget,
    key,
    automaticallyImplyLeading = false,
    bool isGoingBack = true,
    ValueNotifier<double>? visible,
    isTrackDistanceScreen = false,
    bool centerTitle = true}) {
  ValueNotifier<double> newVal = ValueNotifier<double>(1.0);

  return PreferredSize(
    preferredSize: Size.fromHeight(60.h),
    child: ValueListenableBuilder<double>(
      valueListenable: visible ?? newVal,
      builder: (BuildContext context, double value, Widget? child) {
        return Align(
          heightFactor: value,
          alignment: Alignment(0, 0),
          child: Opacity(
            opacity: value,
            child: AppBar(
              centerTitle: centerTitle,
              title: titleWidget,
              backgroundColor: isTrackDistanceScreen ? Colors.white.withOpacity(0.7) : Colors.white.withOpacity(1),
              elevation: isTrackDistanceScreen ? 0 : 3,
              leadingWidth: 45.w,
              automaticallyImplyLeading: automaticallyImplyLeading,
              leading: automaticallyImplyLeading
                  ? Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: IconButton(
                          onPressed: () {
                            isGoingBack
                                ? Get.back()
                                : Get.dialog(
                                    ExitWorkoutDialog(),
                                  );
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 24.r,
                            color: Color(0xff303443),
                          )),
                    )
                  : null,
              actions: [
                InkWell(
                    child: Icon(
                      Icons.online_prediction,
                      color: Color(0xff3BCCE1),
                      size: 25.r,
                    ),
                    onTap: () {
                      Get.dialog(ConnectionDialogCombined(), barrierDismissible: false);
                    }),
                size10,
                InkWell(
                  child: Icon(Icons.notifications, color: Color(0xff3BCCE1), size: 25.r),
                  onTap: () async {
                    var guest = await LocalDB.getInt("userAsGuest");
                    guest == null ? Get.dialog(UserNoticeDialog()) : key.currentState.openEndDrawer();
                  },
                ),
                size10,

                // IconButton(
                //     onPressed: () {
                //       Get.dialog(ConnectionDialogCombined(), barrierDismissible: false);
                //     },
                //     icon: Icon(
                //       Icons.online_prediction,
                //       color: Color(0xff3BCCE1),
                //       size: 25,
                //     )),
                // IconButton(
                //     onPressed: () {
                //       key.currentState.openEndDrawer();
                //     },
                //     icon: Icon(Icons.notifications, color: Color(0xff3BCCE1), size: 25))
              ],
            ),
          ),
        );
      },
      // child: ,
    ),
  );
}
