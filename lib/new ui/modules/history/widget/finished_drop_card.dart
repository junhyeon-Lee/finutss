import 'package:finutss/new%20ui/modules/history/model/history_record_model.dart';
import 'package:finutss/new%20ui/modules/record/widget/run_ride_button.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/presentation/presentation/animation/bouncing.dart';
import 'package:finutss/presentation/widgets/common_widgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';

class FinishedDropCard extends StatelessWidget {
  FinishedDropCard(
      {Key? key, this.color, required this.recordData, required this.onTapDelete,this.isShowDelete=true})
      : super(key: key);

  Color? color;
  RecordsArray recordData;
  VoidCallback onTapDelete;
  String? time;
  bool? isShowDelete;
  final DateFormat timeFormat = DateFormat('hh:mm a');

  @override
  Widget build(BuildContext context) {
    time=DateFormat('hh:mm aa')
        .format(DateTime.parse(recordData.updatedAt ?? '2022-12-06T05:34:42.000Z').toLocal())
        .toString();

    if(time!=null){
      time=Constants.removeAmPm(time??'');
    }


    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(10.w),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.06),
            blurRadius: 18.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    if (recordData.status?.toUpperCase() ==
                        Constants.finished.toLowerCase()) ...[
                      Row(
                        children: [
                          Image.asset(
                            IconAssets.trophy,
                            height: 14.h,
                          ),
                          SizedBox(
                            width: 7.w,
                          ),
                          Text(
                            "FINISHED".tr,
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ],
                      )
                    ] else if (recordData.status?.toUpperCase() ==
                        Constants.drop || recordData.status?.toLowerCase() =='dropped') ...[
                      Text(
                        "DROP".tr,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          letterSpacing: 0.4,
                        ),
                      )
                    ] else if ((recordData.status?? '').toLowerCase() ==
                        Constants.paused || (recordData.status?? '').toLowerCase() =='') ...[
                      Text(
                        Constants.paused,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          letterSpacing: 0.4,
                        ),
                      )
                    ] else if(recordData.status?.toLowerCase() ==
                        Constants.processing.toLowerCase())...[
                      Text(
                        Constants.processing,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          letterSpacing: 0.4,
                        ),
                      )
                    ],
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      time ?? '',
                      style: TextStyle(
                        color: AppColor.subTitleColor.withOpacity(0.6),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                    )
                  ],
                ),
              ),
              RunRideButton(
                height: 23.h,
                width: 58.w,
                isRunMode: recordData.type.toString().toLowerCase() == 'run'
                    ? true
                    : false,
              ),
              SizedBox(
                width: 12.w,
              ),
              (isShowDelete ?? true) ? Bouncing(
                duration: Duration(milliseconds: 100),
                onPressed: onTapDelete,
                child: SvgPicture.asset(
                  IconAssets.deleteRoundIcon,
                  width: 28.w,
                ),
              ) : SizedBox(),
            ],
          ),
          SizedBox(
            height: 14.h,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColor.calibrationCardColor,
              borderRadius: BorderRadius.circular(6.w),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Row(
              children: [
                Image.asset(
                  IconAssets.locationTime,
                  height: 26.h,
                ),
                SizedBox(
                  width: 15.h,
                ),
                Expanded(
                  child: Text(
                    (recordData.track?.name ?? '').toString(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColor.blueTextColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              kmRow(
                IconAssets.location,
                (recordData.distanceInKm ?? 0).toString(),
                "KM".tr,
              ),
              divider(),
              kmRow(
                IconAssets.time,
                (recordData.exerciseTimeInMin ?? 0).toString(),
                "MIN".tr,
              ),
              divider(),
              kmRow(
                IconAssets.kcal,
                (recordData.burnedCal ?? 0).toString(),
                "KCAL".tr,
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
        ],
      ),
    );
  }

  Widget kmRow(String? ImagePath, String? km, String? kmString) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
          ),
          child: Image.asset(
            ImagePath ?? " ",
            height: 20.h,
            color: color,
          ),
        ),
        SizedBox(
          height: 7.h,
        ),
        Row(
          children: [
            Text(
              km ?? "",
              style: TextStyle(
                color: AppColor.blueTextColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              kmString ?? "",
              style: TextStyle(
                color: AppColor.blueTextColor.withOpacity(0.6),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
