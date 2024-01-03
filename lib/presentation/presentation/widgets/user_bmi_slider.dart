import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/edit_body_info_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:measure_size/measure_size.dart';

Widget bmiSlider({required EditBodyInfoController editBodyInfoController, bmi = 10}) {
  List sliderColorList = [
    {'value': '', 'color': Color(0xff54A7E2), 'label': 'Under', 'width': 46},
    {'value': '18.5', 'color': Color(0xff40CE80), 'label': 'Normal', 'width': 12},
    {'value': '23', 'color': Color(0xffFFD24D), 'label': 'Over', 'width': 5},
    {'value': '25', 'color': Color(0xffFD9357), 'label': 'Obesity', 'width': 12},
    {'value': '30', 'color': Color(0xffFF6363), 'label': 'Severe', 'width': 25},
  ];
  return GetBuilder<EditBodyInfoController>(builder: (controller) {
    if (bmi == null) bmi = 10;
    var bmiCirclePosition = controller.bmiBarWidth * bmi / 40;
    return Container(
      child: Row(
        children: [
          Expanded(
            child: MeasureSize(
                onChange: (size) {
                  print('onChange');
                  controller.setBMIBarWidth(size.width);
                  print(size.width);
                },
                child: Stack(children: [
                  Row(
                    children: [
                      for (var i = 0; i < sliderColorList.length; i++)
                        Expanded(
                            flex: sliderColorList[i]['width'],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      sliderColorList[i]['value'],
                                      style: TextStyle(
                                        color: Color(0xff303443),
                                        fontSize: 12.sp,
                                        // fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    size5,
                                    Container(
                                      decoration: BoxDecoration(
                                          color: sliderColorList[i]['color'],
                                          borderRadius: i == 0
                                              ? BorderRadius.only(
                                                  bottomLeft: Radius.circular(10.r), topLeft: Radius.circular(10.r))
                                              : i == sliderColorList.length - 1
                                                  ? BorderRadius.only(
                                                      bottomRight: Radius.circular(10.r),
                                                      topRight: Radius.circular(10.r))
                                                  : BorderRadius.circular(0)),
                                      width: 150.w,
                                      height: 7.h,
                                    ),
                                  ],
                                ),
                                size10,
                                // Text(
                                //   sliderColorList[i]['label'],
                                //   style: TextStyle(
                                //     color: sliderColorList[i]['color'],

                                //     fontSize: 12.sp,
                                //     // fontFamily: "Montserrat",
                                //     fontWeight: FontWeight.w600,
                                //   ),
                                // ),
                              ],
                            )),
                    ],
                  ),
                  Positioned(
                    left: bmiCirclePosition > controller.bmiBarWidth ? controller.bmiBarWidth - 20 : bmiCirclePosition,
                    top: 13.h,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black45)]),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 11.r,
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 9.r,
                            ),
                          ),
                        ),
                        Text(
                          sliderColorList[0]['label'],
                          style: TextStyle(
                            color: sliderColorList[0]['color'],

                            fontSize: 12.sp,
                            // fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                ])),
          )
          //   Container(
          //     width: 250,
          //     height: 12,
          //     child:
          //     Stack(
          //       alignment: Alignment.center,
          //       children: [
          //         Positioned(
          //           left: 0,
          //           child: Container(
          //               width: 150,
          //               child: Align(
          //                 alignment: Alignment.centerRight,
          //                 child: Text(
          //                   "30",
          //                   style: TextStyle(
          //                     color: Color(0xff303443),
          //                     fontSize: 12,
          //                     // fontFamily: "Montserrat",
          //                     fontWeight: FontWeight.w600,
          //                   ),
          //                 ),
          //               ),
          //           ),
          //         ),
          //         Positioned(
          //           left: 0,
          //           child: Container(
          //               width: 100,
          //             child: Align(
          //               alignment: Alignment.centerRight,
          //               child: Text(
          //                 "25",
          //                 style: TextStyle(
          //                   color: Color(0xff303443),
          //                   fontSize: 12,
          //                   // fontFamily: "Montserrat",
          //                   fontWeight: FontWeight.w600,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Positioned(
          //           left: 0,
          //           child: Container(
          //               width: 80,
          //             child: Align(
          //               alignment: Alignment.centerRight,
          //               child: Text(
          //                 "23",
          //                 style: TextStyle(
          //                   color: Color(0xff303443),
          //                   fontSize: 12,
          //                   // fontFamily: "Montserrat",
          //                   fontWeight: FontWeight.w600,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Positioned(
          //           left: 0,
          //           child: Container(
          //               width: 35,
          //             child: Align(
          //               alignment: Alignment.centerRight,
          //               child: Text(
          //                 "18.5",
          //                 style: TextStyle(
          //                   color: Color(0xff303443),
          //                   fontSize: 12,
          //                   // fontFamily: "Montserrat",
          //                   fontWeight: FontWeight.w600,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),

          //       ],
          //     ),
          //   ),
          //   size5,
          //   Container(
          //     width: 250,
          //     height: 23,
          //     child: Stack(
          //       alignment: Alignment.center,
          //       children: [
          //         Positioned(
          //           left: 0,
          //           child: Container(
          //               width: 250,
          //               height: 10,
          //               color: Color(0xffff6262)
          //           ),
          //         ),
          //         Positioned(
          //           left: 0,
          //           child: Container(
          //               width: 150,
          //               height: 10,
          //               color: Color(0xfffc9357)
          //           ),
          //         ),
          //         Positioned(
          //           left: 0,
          //           child: Container(
          //               width: 100,
          //               height: 10,
          //               color: Color(0xffffd24c)
          //           ),
          //         ),
          //         Positioned(
          //           left: 0,
          //           child: Container(
          //             width: 80,
          //             height: 10,
          //             color: Color(0xff40ce80)
          //           ),
          //         ),
          //         Positioned(
          //           left: 0,
          //           child: Container(
          //             width: 35,
          //               height: 10,
          //               color: blueColor
          //           ),
          //         ),
          //         Positioned(
          //           left: 0,
          //           child: Container(
          //             width: width,
          //             child: Align(
          //               alignment: Alignment.centerRight,
          //               child: Container(
          //                 width: 23,
          //                 height: 23,
          //                 decoration: BoxDecoration(
          //                     shape: BoxShape.circle,
          //                     border: Border.all(color: Colors.white, width: 3, ),
          //                     color: width < 35
          //                         ?blueColor
          //                         :width< 80
          //                         ?Color(0xff40ce80)
          //                         :width< 100
          //                         ?Color(0xffffd24c)
          //                         :width< 150
          //                         ?Color(0xfffc9357)
          //                         :Color(0xffff6262)

          //                 ),
          //               ),
          //             ),
          //           )
          //         ),
          //       ],
          //     ),
          //   ),
        ],
      ),
    );
  });
}
