import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/workout_record_controller.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:finutss/data/graphql_operation/queries/WorkOutQueries.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/divider.dart';
import 'package:finutss/presentation/widgets/dialogs/record_dialogs/delete_record_dialog.dart';
import 'package:finutss/presentation/widgets/from_to_heading_widget.dart';
import 'package:finutss/presentation/widgets/social_page_widgets/info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class TrackRecordCalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundSilver,
      appBar: simpleAppBar(
        text: 'HISTORY_WORKOUT'.tr,
        automaticallyImplyLeading: true,
      ) as PreferredSizeWidget?,
      body: SingleChildScrollView(
        child: Column(
          children: [HistoryCalendar()],
        ),
      ),
    );
  }
}

class HistoryCalendar extends StatefulWidget {
  @override
  State<HistoryCalendar> createState() => _HistoryCalendarState();
}

class _HistoryCalendarState extends State<HistoryCalendar> {
  final workoutRecordController = Get.put(WorkoutRecordController());
  final authController = Get.put(AuthController());

  var _selectedDay;
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    await workoutRecordController.callApiRecordByMonth();
    workoutRecordController.setWorkListOfDay(DateTime.now());
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
      });
      workoutRecordController.setWorkListOfDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkoutRecordController>(builder: (workoutRecordController) {
      List _getEventsForDay(DateTime day) {
        var values;
        if (workoutRecordController.workOutsOfMonth != null && workoutRecordController.workOutsOfMonth.length > 0) {
          var isExsit = workoutRecordController.workOutsOfMonth.firstWhere((item) {
            var selectDay = DateTime.parse(item['createdAt']);
            return (selectDay.day == day.day && selectDay.month == day.month);
          }, orElse: () => null);
          if (isExsit != null) {
            values = [
              {"ok": "ok"}
            ];
          }
        }
        return values ?? [];
      }

      return Column(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
            margin: EdgeInsets.only(top: 16, left: 16, right: 16),
            padding: EdgeInsets.only(bottom: 10),
            child: TableCalendar(
              rowHeight: 50.h,
              /* --------------------------------- header --------------------------------- */
              headerStyle: HeaderStyle(
                titleCentered: true,
                titleTextStyle: TextStyle(fontSize: 15.sp),
                formatButtonVisible: false,
                formatButtonShowsNext: false,
                leftChevronMargin: EdgeInsets.symmetric(horizontal: 30.w),
                rightChevronMargin: EdgeInsets.symmetric(horizontal: 30.w),
              ),
              /* -------------------------------- main days ------------------------------- */
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: _onDaySelected,
              calendarFormat: workoutRecordController.calendarFormat,
              eventLoader: _getEventsForDay,
              calendarStyle: CalendarStyle(
                  cellMargin: EdgeInsets.symmetric(vertical: 8.5.h, horizontal: 6.w),
                  todayDecoration: BoxDecoration(),
                  todayTextStyle: TextStyle(),
                  markerDecoration: BoxDecoration(color: colorPink, shape: BoxShape.circle),
                  markerMargin: EdgeInsets.only(top: 5)),
              focusedDay: workoutRecordController.focusedDay,
              firstDay: workoutRecordController.firstDay,
              lastDay: workoutRecordController.lastDay,

              // selectedDayPredicate: (day) {
              //   return isSameDay(workoutRecordController.selectedDay, day);
              // },

              /* -------------------------------- builders -------------------------------- */
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, date, events) => Container(
                  height: 30.h,
                  width: 30.h,
                  margin: EdgeInsets.all(4.0.r),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: colorBlue, borderRadius: BorderRadius.circular(50.0.r)),
                  child: customText(
                    text: date.day.toString(),
                    fontColor: Color(0xFFFFFFFFF),
                  ),
                ),
              ),
              onPageChanged: (focusedDay) async {
                workoutRecordController.focusedDay = focusedDay;
                workoutRecordController.callApiRecordByMonth();
              },
            ),
          ),
          if (workoutRecordController.workOutsOfDay != null)
            for (var item in workoutRecordController.workOutsOfDay) _finishedOrDropCard(item),
          if (workoutRecordController.workOutsOfDay == null || workoutRecordController.workOutsOfDay.length == 0)
            _noRecordCard()
        ],
      );
    });
  }

  /* -------------------------------------------------------------------------- */
  /*                                finishedCard                                */
  /* -------------------------------------------------------------------------- */
  _finishedOrDropCard(item, {String title = 'Drop', titleColor = Colors.blue, isFinished = false}) {
    title = 'DROP'.tr;
    if (item["finish"] == true) {
      titleColor = Color(0xff14C664);
      isFinished = true;
      title = 'FINISHED'.tr;
    } else {
      titleColor = Color(0xffFFCB46);
    }

    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 16.h),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
        // height: 40,
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r))),
              color: colorLightGrey,
              child: Row(
                children: [
                  size15,
                  isFinished
                      ? Image.asset(
                          'assets/images/trophy.png',
                          height: 20.h,
                        )
                      : Container(),
                  size5,
                  Text(
                    title,
                    style: TextStyle(color: titleColor, fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                  size10,
                  Text(
                    LocalDB.convertDateFormat(item['createdAt'], "HH:mm a"),
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 12.sp,
                    ),
                  ),
                  size5,
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 5.5.w),
                    child: customButton(
                        onTapFunction: () {
                          Get.to(() => TrackRecordCalendarScreen());
                        },
                        text: item["workoutType"] == "Riding" ? 'WORKOUT_TYPE_RIDE'.tr : 'WORKOUT_TYPE_RUN'.tr,
                        height: 20,
                        width: 60,
                        textSize: 10,
                        color: item["workoutType"] == "Riding" ? colorPictonBlue : colorPink,
                        textColor: colorWhite,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                      padding: EdgeInsets.only(right: 5.w, left: 5.w, top: 5.h, bottom: 5.h),
                      child: CircleAvatar(
                        backgroundColor: colorWhitish,
                        maxRadius: 15.r,
                        child: Center(
                            child: InkWell(
                          onTap: () {
                            Get.dialog(
                              DeleteRecordDialog(
                                title: 'NOTICE'.tr,
                                description: 'RECORD_DELETE_WARNING_GUIDE'.tr,
                                callback: () {
                                  GlobalBloc().queryMutate(WorkOutQueries.REMOVE_WORKOUT, {"id": item["id"]}).then((res) {
                                    if (!res["success"]) {
                                      LocalDB.snackbar("Alert", res["message"]);
                                      return;
                                    }
                                    LocalDB.snackbar("Alert", "success");

                                    workoutRecordController.workOutsOfMonth.remove(item);
                                    workoutRecordController.update();
                                  });
                                },
                              ),
                            );
                          },
                          child: Icon(
                            Icons.delete_outline,
                            size: 20.r,
                            color: Colors.white,
                          ),
                        )),
                      ))
                ],
              ),
            ),
            size10,
            fromToHeading(
                backgroundColor: colorBackgroundSilver,
                to: item["track"] != null ? item["track"]["sName"] : "",
                from: item["track"] != null ? item["track"]["eName"] : ""),
            size15,
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  size5,
                  infoCard(
                    header: 'DISTANCE'.tr,
                    footer: "${item["distance"] != null ? (item["distance"] / 1000).toStringAsFixed(1) : 0} km",
                    image: "destination.png",
                  ),
                  divider(),
                  infoCard(
                    header: 'TIME'.tr,
                    footer: "${(item["duration"] != null ? (item["duration"] / 60).toStringAsFixed(0) : 0)} min",
                    image: "time.png",
                  ),
                  divider(),
                  infoCard(
                    header: "BURNED".tr,
                    footer: "${item["kcal"] != null ? (item["kcal"].toStringAsFixed(1)) : 0} kcal",
                    image: "calories.png",
                  ),
                  size5,
                ],
              ),
            ),
            size15,
          ],
        ),
      ),
    );
  }

  /* -------------------------------------------------------------------------- */
  /*                                    empty                                   */
  /* -------------------------------------------------------------------------- */
  _noRecordCard() {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
        // height: 40,
        width: double.infinity.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            size35,
            Image.asset(
              'assets/images/no_record.png',
              height: 191.h,
              width: 115.w,
            ),
            size5,
            customText(
              text: 'There is no workout record',
              fontColor: colorWhitish,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            size35,
          ],
        ),
      ),
    );
  }
}
