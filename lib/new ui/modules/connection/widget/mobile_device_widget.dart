import 'package:finutss/new%20ui/controller/new_sensor_controller.dart';
import 'package:finutss/new%20ui/modules/home/widget/position_style_widget.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class MobileDeviceWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? checkOnTap;
  final VoidCallback? onTapRetry;
  final String? position;
  final String? positionDescription;
  final String? buttonTitle;
  final String? checkIcon;
  final String? completeDes;
  final String? completeButtonTitle;
  final int? index;
  final bool? isSelected;
  final bool? isChoose;

  MobileDeviceWidget(
      {this.onTap,
      this.checkOnTap,
      this.onTapRetry,
      this.positionDescription,
      this.position,
      this.buttonTitle,
      this.checkIcon,
      this.completeDes,
      this.completeButtonTitle,
      this.index,
      this.isSelected,
      this.isChoose});

  //ValueNotifier<bool> isSelect = ValueNotifier(false);
  NewSensorController sensorController = Get.find();


  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 13.w,
        vertical: 15.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.whiteColor[100],
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                position?.tr ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColor.blueTextColor[100],
                  fontSize: 17.sp,
                ),
              ),
              GestureDetector(
                child: Image.asset(
                  checkIcon ?? '',
                  scale: 3,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 3.5.h,
          ),
          Constants.isSelectWearPosition.value == true || index==2 && isSelected==true || index==1 && isSelected==true
              ? SizedBox()
              : Column(
                children: [
                  Text(
                      positionDescription?.tr ?? "",
                      style: TextStyle(
                        color: AppColor.blueTextColor.withOpacity(0.7),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),

          if (index == 0 && (isChoose ?? false))
            Obx(() {
              return  Constants.isSelectWearPosition.value == true
                ? PositionStyleWidget(
              editOnTap: () {
                Constants.isSelectWearPosition.value = false;
              },
              isSelected: true,
              onTap: () {},
              position: Constants.wearPosition?.position ?? '',
              positionDes: Constants.wearPosition?.positionDescription ?? '',
              positionImage: Constants.wearPosition?.positionImage ?? '',
            )
                : ListView.builder(
              shrinkWrap: true,
              itemCount: Constants.wearPositionModelList.length,
              itemBuilder: (context, index) {
                return PositionStyleWidget(
                  onTap: () {
                    sensorController.setWorkoutType(Constants.mobileSensor);
                    Constants.isSelectWearPosition.value = true;
                    Constants
                        .positionModelList[0].isSelected.value=true;
                    Constants.wearPosition =
                    Constants.wearPositionModelList[index];
                    },
                  position: Constants
                      .wearPositionModelList[index].position,
                  positionDes: Constants
                      .wearPositionModelList[index]
                      .positionDescription,
                  positionImage: Constants
                      .wearPositionModelList[index].positionImage, editOnTap: () {  },
                );
              },
            );
            })
          else if(index==2 && isSelected==true || index==1 && isSelected==true)
            Container(
              height: 65.h,
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(8.w),
              ),
              margin: EdgeInsets.only(top: 4.h),
              child: Padding(
                padding: EdgeInsets.only(left: 20.w,right: 12.w,top: 10.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Expanded(
                     child: Padding(
                       padding: EdgeInsets.only(top: 8.h),
                       child: Text(completeDes?.tr ?? '',style: TextStyle(
                         color : AppColor.subTitleColor.withOpacity(0.5),
                         fontWeight: FontWeight.w400,
                         fontSize: 13.sp,
                       ),),
                     ),
                   ),


                    SizedBox(
                      width: 18.w,
                    ),

                    GestureDetector(
                      onTap: onTap,
                      child: Text(completeButtonTitle?.tr ?? '',style: TextStyle(
                        color : AppColor.orangeColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                      ),),
                    ),
                  ],
                ),
              ),
            )
          else
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 55.0.h),
              child: CustomButton(
                onTap: onTap,
                borderRadius: 10,
                padding: EdgeInsets.symmetric(vertical: 9.h),
                isShowBorder: false,
                title: buttonTitle?.tr ?? '',
              ),
            )
        ],
      ),
    );
  }
}
