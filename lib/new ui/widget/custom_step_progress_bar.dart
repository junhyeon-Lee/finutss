import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomStepProgressBar extends StatelessWidget {
   CustomStepProgressBar({this.max=100,this.currentValue=0,this.height});

  int maxLength=5;
  int currentValue;
  double? height;
  List<Color> colorList=[
    AppColor.skyBlue,
    AppColor.sliderGreenColor,
    AppColor.sliderYellowColor,
    AppColor.sliderOrangeColor,
    AppColor.sliderPinkColor,
  ];
  int max=100;
  double containerWidth=0;
  Color unSelectColor=AppColor.sliderBGColor;

  @override
  Widget build(BuildContext context) {
    containerWidth=MediaQuery.of(context).size.width-40.w;
    containerWidth=containerWidth/max;
    return Container(
      width: double.infinity,
      height: height ?? 7.h,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        child: Row(
          children: [
          //  for(int i=0; i<maxLength; i++)
          Expanded(child: getWidgets()),


          ],
        ),
      ),
    );
  }


  Widget getWidgets(){
    return Row(
      children: [
        for(int j=0; j<max; j++)
          Container(
            width: containerWidth,
            decoration: BoxDecoration(
              color: getColor(j+1),
            ),
          )
      ],
    );
  }


  Color getColor(int progressValue){

    if(progressValue<=20){
      print('------j value--------${progressValue}');
      if(progressValue<=currentValue){
        return colorList[0];
      }else{
        return unSelectColor;
      }
    }else if(progressValue<=40){
      print('====================${progressValue}');
      if(progressValue<=currentValue){
        return colorList[1];
      }else{
        return unSelectColor;
      }
    }else if(progressValue<=60){
      if(progressValue<=currentValue){
        return colorList[2];
      }else{
        return unSelectColor;
      }
    }else if( progressValue<=80){
      if(progressValue<=currentValue){
        return colorList[3];
      }else{
        return unSelectColor;
      }
    }else if(progressValue<=100){

      if(progressValue<=currentValue){
        return colorList[4];
      }else{
        return unSelectColor;
      }
    }else{
      return unSelectColor;
    }
  }

}
