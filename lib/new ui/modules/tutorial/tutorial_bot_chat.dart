import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TutorialBotChat extends StatelessWidget {
  const TutorialBotChat({Key? key, required this.text, required this.user}) : super(key: key);

  final String text;
  final bool user;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(20,0,20,15),
      child: user?Row(mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 240.w,
            // height: 75.h,
            child:Padding(
              padding: const EdgeInsets.all(9.0),
              child: Center(
                child: Text(text ,softWrap: true, textAlign : TextAlign.center,style : TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  height: 0.9,
                ),),
              ),
            ),
            decoration: BoxDecoration(color: AppColor.orangeColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(10.0)
                  ,topLeft: Radius.circular(10.0),bottomLeft: Radius.circular(10.0)),),
          ),
        ],
      ):Row(
        children: [
          Container(
            width: 240.w,
            // height: 75.h,
            child:Padding(
              padding: const EdgeInsets.all(9.0),
              child: Center(
                child: Text(text ,softWrap: true, textAlign : TextAlign.center,style : TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  height: 0.9,
                ),),
              ),
            ),
            decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(10.0)
                  ,topLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0)),),
          ),
        ],
      ),
    );
  }
}
