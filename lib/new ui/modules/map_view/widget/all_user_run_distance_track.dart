import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AllUserRunDistanceTrack extends StatelessWidget {
  final List userList;
  final int speed;
  const AllUserRunDistanceTrack({Key? key, required this.speed, required this.userList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int level = 3;
    if ((speed / 10) > 3) {
      level = 3;
    } else if ((speed / 10 == 0)) {
      level = 0;
    } else {
      level = speed ~/ 10;
    }
    return Container(
      height: 7.h,
      width: Get.width - 40.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color(0xFFADADB1),
      ),
      child: Stack(
        children: [
          for (var i = level; i > -1; i--)
            Container(
              decoration: BoxDecoration(
                color: userList[i]['color'],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(5.r), bottomLeft: Radius.circular(5.r)),
              ),
              height: 7.h,
              width: Get.width * (userList[i]['percent'] / 100),
            )
        ],
      ),
    );
  }
}
