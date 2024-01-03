import 'package:finutss/new%20ui/modules/history/widget/delete_track_record_dialog.dart';
import 'package:finutss/new%20ui/modules/history/widget/finished_drop_card.dart';
import 'package:finutss/new%20ui/modules/record/controller/record_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:finutss/new%20ui/widget/cutom_home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({Key? key}) : super(key: key);

  RecordController recordController=Get.find();
  final DateFormat format = DateFormat('yyyy-MM-dd');


  @override
  Widget build(BuildContext context) {
    recordController.selectedDay =
        format.format(recordController.focusedDay.value);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      recordController.getUserID().then((value) {
        recordController.getRecordFromDate();
      });
    });


    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 11.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomHomeAppBar(
                lastImagePath: IconAssets.calendar,
                title: "HISTORY_WORKOUT".tr,
                onTapLastIcon: () {
                },
              ),
            ),
            SizedBox(
              height: 21.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: Column(
                    children: [
                      calendarView(),
                      SizedBox(
                        height: 12.h,
                      ),
                      recordListView(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget calendarView(){
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.06),
            blurRadius: 20.0,
          ),
        ],
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(
          14.w,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 5.w,
          right: 5.w,
          bottom: 11.h,
        ),
        child: Obx(() {
          return TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.now(),
            onDaySelected: (selectedDay, focusedDay) {
              if(!recordController.isLoading.value) {
                if (!isSameDay(
                    recordController.focusedDay.value,
                    selectedDay)) {
                  recordController.focusedDay.value =
                      focusedDay;

                  recordController.selectedDay =
                      format.format(selectedDay);

                  recordController.getRecordFromDate();
                }
              }
            },
            focusedDay: recordController.focusedDay.value,
            currentDay: recordController.focusedDay.value,
            pageJumpingEnabled:true,
            rowHeight: 30.h,
            daysOfWeekHeight: 20.h,
            daysOfWeekStyle: DaysOfWeekStyle(
              dowTextFormatter: (date, locale) =>
                  DateFormat.E(locale)
                      .format(date)
                      .substring(0, 1),
              weekdayStyle: TextStyle(
                color: AppColor.blue,
                fontWeight: FontWeight.w700,
                fontSize: 11.sp,
              ),
              weekendStyle: TextStyle(
                color: AppColor.blue,
                fontWeight: FontWeight.w700,
                fontSize: 11.sp,
              ),
            ),
            calendarStyle: CalendarStyle(
              cellPadding: EdgeInsets.zero,
              /*  isTodayHighlighted: true,
                              selectedDecoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                                borderRadius: BorderRadius.circular(5.0),
                              ),*/
              weekendTextStyle: TextStyle(
                color:
                AppColor.black,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
              holidayTextStyle: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp),
              outsideTextStyle: TextStyle(
                color:
                AppColor.black,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
              rangeEndTextStyle: TextStyle(
                color:
                AppColor.black,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
              rangeStartTextStyle: TextStyle(
                color:
                AppColor.black,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
              todayTextStyle:  TextStyle(
                color:
                AppColor.whiteColor,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
              /* selectedTextStyle: TextStyle(
                                color: Colors.black,
                              ),*/
              defaultTextStyle: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp),

              selectedDecoration: BoxDecoration(
                color: AppColor.dayBG,
                shape: BoxShape.circle,
              ),
              disabledTextStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp,
                color: AppColor.black.withOpacity(0.5),
              ),
              selectedTextStyle: TextStyle(
                  color: AppColor.purple,
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              titleTextStyle: TextStyle(
                color: AppColor.purple,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: AppColor.iconColorBg,
                size: 20.w,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: AppColor.iconColorBg,
                size: 20.w,
              ),
              formatButtonVisible: false,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonTextStyle: TextStyle(
                color: Colors.blue,
              ),
            ),
          );
        }),
      ),
    );
  }


  Widget recordListView(){
    return Obx(() {
      return recordController.historyRecordList.length == 0 || recordController.isLoading.value ? CustomVIew.noRecordLayout(title: "THERE_IS_NO_RECORD_OF_WORKOUT",isLoading: recordController.isLoading.value) : ListView.separated(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 14.h),
        itemBuilder: (context,i){
          return FinishedDropCard(
            recordData: recordController.historyRecordList[i],
            color: AppColor.greenSliderBg,
            onTapDelete: (){
              deleteTrackRecordDialog(context: context,index: i,recordId: recordController.historyRecordList[i].id ?? '');
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 12.h,
          );
        },
        itemCount: recordController.historyRecordList.length,
      );
    });
  }

}
