import 'package:finutss/domain/controller/dummy_data_controller.dart';
import 'package:finutss/domain/controller/workout_record_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import 'common_widgets/custom_text.dart';

Widget workoutRecordSlider() {
  final DummyDataController dummyDataController = Get.put(DummyDataController());
  final WorkoutRecordController workoutRecordController = Get.put(WorkoutRecordController());
  var nowDay = DateTime.now().weekday;

  return Container(
    height: 40.h,
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.5.w),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 5,
                width: Get.width,
                color: colorLightSilver.withOpacity(0.5),
              ),
              Container(
                height: 5,
                width: (Get.width - 12) * nowDay / 7,
                color: colorBlue.withOpacity(0.5),
              ),
              Positioned.fill(
                  top: -7.h,
                  left: 0,
                  right: 0,
                  bottom: -50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: workOutRecordSliderCell(workoutRecordController),
                  )),
              // for (int i = 0;
              //     i < dummyDataController.userWorkoutRecord.length;
              //     i++)
              //   Positioned(
              //       // left: dummyDataController.userWorkoutRecord[i]
              //       //     ['leftPosition'],
              //       // left: (Get.width /
              //       //         (dummyDataController.userWorkoutRecord.length + 1)) *
              //       //     i,
              //       top: dummyDataController.userWorkoutRecord.length - 1 == i
              //           ? -18
              //           : -7,
              //       bottom: 0,
              //       left: (Get.width /
              //                   (dummyDataController.userWorkoutRecord.length +
              //                       1) +
              //               5) *
              //           i,
              //       child: dummyDataController.userWorkoutRecord.length - 1 == i
              //           ? Image.asset('assets/images/trophy.png')
              //           : Icon(
              //               Icons.circle,
              //               color: dummyDataController.userWorkoutRecord[i]
              //                   ['iconColor'],
              //               size: 20,
              //             )),
              // Positioned(
              //   right: -2,
              //   bottom: 0,
              //   child: Image.asset('assets/images/trophy.png'),
              // ),
            ],
          ),
        ),
        // size30,
        // Padding(
        //   padding: EdgeInsets.only(left: 16.w, right: 16.w),
        //   child: Stack(
        //     clipBehavior: Clip.none,
        //     children: [
        //       Container(
        //         // height: 20,
        //         width: Get.width,
        //       ),
        //       Positioned(
        //         top: -6,
        //         // left: dummyDataController.userWorkoutRecord[i]['leftPosition'],
        //         left: 0,
        //         right: 0,
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             for (int i = 0;
        //                 i < dummyDataController.userWorkoutRecord.length;
        //                 i++)
        //               dummyDataController.userWorkoutRecord.length - 1 == i
        //                   ? SizedBox(
        //                       width: 30,
        //                     )
        //                   : Container(
        //                       width: 32,
        //                       child: customText(
        //                           text: dummyDataController.userWorkoutRecord[i]
        //                               ['value'],
        //                           fontColor: dummyDataController
        //                               .userWorkoutRecord[i]['textColor'],
        //                           fontSize: 12,
        //                           fontWeight: FontWeight.w500),
        //                     ),
        //             // SizedBox()
        //           ],
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ],
    ),
  );
}

List<Widget> workOutRecordSliderCell(WorkoutRecordController workoutRecordController) {
  var nowDay = DateTime.now().weekday;
  List<Widget> list = [];
  for (int i = 0; i < 7; i++) {
    if (workoutRecordController.jsonWorkWeekTotalObject != null)
      for (int j = 0; j < workoutRecordController.jsonWorkWeekTotalObject.length; j++) {
        var item = workoutRecordController.jsonWorkWeekTotalObject[j];
        if (item["_id"]["day"] == (i + 7) % 7 + 1) {
          var widget = Transform.translate(
            offset: Offset(i == 0 ? -8.h : 0, 0),
            child: Column(
              children: [
                Icon(
                  Icons.circle,
                  color: nowDay == i ? colorPink : colorBlue,
                  size: 20.r,
                ),
                size10,
                customText(
                    text: item['kcal'].toStringAsFixed(1),
                    fontColor: nowDay == i ? colorPink : colorBlue,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ],
            ),
          );
          list.add(widget);
        }
      }
    if (list.length == i) {
      if (i == 6) {
        list.add(Transform.translate(
            offset: Offset(7.w, -3.h),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/trophy.png',
                  height: 24.h,
                ),
                size10
              ],
            )));
      } else {
        print("Get.width ${Get.width} ${Get.width / 7}");
        list.add(Transform.translate(
          offset: Offset(i == 0 ? -8.h : 0, 0),
          child: Column(
            children: [
              Icon(
                Icons.circle,
                color: i > nowDay ? colorLightSilver : colorBlue,
                size: 20.r,
              ),
              size10,
            ],
          ),
        ));
      }
    }
  }
  return list;
}
