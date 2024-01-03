import 'package:finutss/new%20ui/modules/record/controller/bmi_slider_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:measure_size/measure_size.dart';

Widget bmiSlider(
    {required BmiSliderController bmiSliderController,
    bmi = 10,
    bool showLabel = true}) {
  List sliderColorList = [
    {
      'value': '',
      'color': Color(0xff54A7E2),
      'label': 'UNDER',
      'width': 20,
    },
    {
      'value': '18.5',
      'color': Color(0xff40CE80),
      'label': 'NORMAL',
      'width': 20,
    },
    {
      'value': '23',
      'color': Color(0xffFFD24D),
      'label': 'OVER',
      'width': 20,
    },
    {
      'value': '25',
      'color': Color(0xffFD9357),
      'label': 'OBESITY',
      'width': 20,
    },
    {
      'value': '30',
      'color': Color(0xffFF6363),
      'label': 'SEVERE',
      'width': 25,
    },
  ];
  return GetBuilder<BmiSliderController>(builder: (controller) {
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
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Color(0xff303443),
                                      fontSize: 12.sp,
                                      // fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: sliderColorList[i]['color'],
                                        borderRadius: i == 0
                                            ? BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(10.r),
                                                topLeft: Radius.circular(10.r))
                                            : i == sliderColorList.length - 1
                                                ? BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(10.r),
                                                    topRight:
                                                        Radius.circular(10.r))
                                                : BorderRadius.circular(0)),
                                    width: 120.w,
                                    height: 7.h,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Container(
                                    height: 20.h,
                                    child: showLabel
                                        ? Center(
                                          child: Text(
                                              sliderColorList[i]['label'].toString().tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: sliderColorList[i]['color'],
                                                fontSize: 12.sp,
                                                // fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                        )
                                        : Container(),
                                  ),
                                ],
                              ),

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
                          ),
                        ),
                    ],
                  ),
                  Positioned(
                    left: bmiCirclePosition > controller.bmiBarWidth ? controller.bmiBarWidth - 20 : bmiCirclePosition,
                    top: 15.h,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(blurRadius: 5, color: Colors.black45)
                              ]),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 10.r,
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 9.r,
                            ),
                          ),
                        ),
                       /* Container(
                          child: Center(
                            child: Text(
                              sliderColorList[0]['label'].toString().tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: sliderColorList[0]['color'],

                                fontSize: 12.sp,
                                // fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),*/
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
