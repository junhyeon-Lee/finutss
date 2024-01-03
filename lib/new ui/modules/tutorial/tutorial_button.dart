import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TutorialButton extends StatelessWidget {
  const TutorialButton({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45.h,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: Color(0xffff8c41), width: 1.5)),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
