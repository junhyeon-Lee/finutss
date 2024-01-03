import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumberStepper extends StatelessWidget {
  final double width;
  final totalSteps;
  final int curStep;
  final Color stepCompleteColor;
  final Color currentStepColor;
  final Color inactiveColor;
  final double lineWidth;
  final VoidCallback? onTap;
  final int stepLength = 7;
  List<String> stepList;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 10.h,
            left: 5.w,
            right: 5.w,
          ),
          width: this.width,
          child: Stack(
            children: [
              Row(
                children: _steps(),
              ),


              Padding(
                padding: EdgeInsets.only(top: 28.h),
                child: Row(
                  children: textSteps(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  NumberStepper({
    Key? key,
    required this.width,
    required this.curStep,
    required this.stepCompleteColor,
    @required this.totalSteps,
    required this.inactiveColor,
    required this.currentStepColor,
    required this.lineWidth,
    required this.stepList,
    this.onTap,
  })  : assert(curStep > 0 == true && curStep <= totalSteps + 1),
        super(key: key);

  getCircleColor(i) {
    var color;
    if (i + 1 < curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep)
      color = currentStepColor;
    else
      color = Color(0XFFDBE3EE);
    return color;
  }

  getBorderColor(i) {
    var color;
    if (i + 1 < curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep)
      color = currentStepColor;
    else
      color = inactiveColor;

    return color;
  }

  getLineColor(i) {
    var color = curStep > i + 1 ? Color(0XFFE8D3FF) : Colors.grey[200];
    return color;
  }

  List<Widget> _steps() {
    var list = <Widget>[];
    for (int i = 0; i < totalSteps; i++) {
      var circleColor = getCircleColor(i);
      var borderColor = getBorderColor(i);
      var lineColor = getLineColor(i);

      list.add(
        i == stepLength - 1
            ? Image.asset(
                IconAssets.trophy,
                width: 30.w,
                height: 30.w,
              )
            : InkWell(
                onTap: onTap,
                child: Column(
                  children: [
                    Container(
                      width: 12.w,
                      height: 12.w,
                      child: getInnerElementOfStepper(i),
                      decoration: new BoxDecoration(
                        color: circleColor,
                        borderRadius: new BorderRadius.all(
                          new Radius.circular(
                            25.0,
                          ),
                        ),
                        border: new Border.all(
                          color: borderColor,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      );

      if (i != totalSteps - 1) {
        list.add(
          Expanded(
            child: Container(
              height: lineWidth,
              color: lineColor,
            ),
          ),
        );
      }
    }
    return list;
  }



  List<Widget> textSteps() {
    var list = <Widget>[];
    for (int i = 0; i < stepList.length; i++) {
      list.add(
        i == stepLength - 1
            ? Container(
          width: 30.w,
        ) : i<curStep ? Expanded(
          child: Text(stepList[i].toString(),style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.subTitleColor.withOpacity(0.5)
          ),),
        ) : Expanded(
            child: Text("0",style: TextStyle(color: Colors.transparent),)),
      );

     /* if (i != totalSteps - 1) {
        list.add(
          Expanded(
            child: Container(
              height: lineWidth,
            ),
          ),
        );
      }*/
    }
    return list;
  }

  Widget getInnerElementOfStepper(index) {
    if (index + 1 < curStep) {
      return Icon(
        Icons.check,
        color: Colors.white,
        size: 8.0,
      );
    } else
      return Container();
  }
}
