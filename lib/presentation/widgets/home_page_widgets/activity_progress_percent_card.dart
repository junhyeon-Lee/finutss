import 'package:finutss/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget activityProgressCard({
  bool isCompleted = false,
  onPressedFunction,
  required context,
  double kcal = 0,
  double bmr = 2000,
}) {
  return InkWell(
    onTap: onPressedFunction,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        height: 135,
        width: MediaQuery.of(context).size.width / 2.3,

        // width: Get.width * 0.4,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27.w),
          child: Column(
            children: [
              size10,
              Text(
                'DAILY_TRAINING'.tr,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 3, width: 3),
              /* -------------------------------------------------------------------------- */
              /*                              progress and icon                             */
              /* -------------------------------------------------------------------------- */
              Stack(
                clipBehavior: Clip.none,
                children: [
                  circularProgress(isCompleted: isCompleted, kcal: kcal, bmr: bmr),
                  Positioned(
                      bottom: -10,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                          width: 35,
                          height: 30,
                          child: IgnorePointer(
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: onPressedFunction,
                              icon: Icon(
                                isCompleted == true ? Icons.thumb_up_alt : Icons.run_circle,
                                size: 32,
                                color: colorBlue,
                              ),
                            ),
                          ),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

/* -------------------------------------------------------------------------- */
/*                              circular progress                             */
/* -------------------------------------------------------------------------- */
Widget circularProgress({bool isCompleted = false, double kcal = 0, double bmr = 2000}) {
  print('$kcal / $bmr = ${kcal / bmr}');
  var percent = 0.0;
  if (kcal != 0 && bmr != 0) {
    percent = kcal / bmr;
    if (percent > 1) isCompleted = true;
  }

  if (isCompleted) {
    percent = 1;
  }

  return Container(
    height: 90,
    width: 90,
    child: CircularPercentIndicator(
      lineWidth: 5,
      percent: percent,
      startAngle: 200,
      progressColor: isCompleted == true ? Color(0xff94CF76) : Color(0xffF73A6B),
      radius: 90,
      center: Container(
        height: 90 / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              kcal.roundToDouble().toString(),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isCompleted == true ? Color(0xff94CF76) : Color(0xffF73A6B)),
            ),
            Text(
              isCompleted == true ? 'Completed' : '/${bmr.toStringAsFixed(0)} kcal',
              style: TextStyle(fontSize: 8, color: Color(0xff7F8391)),
            ),
          ],
        ),
      ),
    ),
  );
}
