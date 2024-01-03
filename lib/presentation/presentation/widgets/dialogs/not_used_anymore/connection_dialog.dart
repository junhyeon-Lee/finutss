// import 'package:finutss/controller/sensor_controller.dart';
// import 'package:finutss/views/widgets/common_widgets/constants.dart';
// import 'package:finutss/views/widgets/common_widgets/heading_widget.dart';
// import 'package:finutss/views/widgets/dialogs/sensor_dialogs/connection_status_dialog.dart';
// import 'package:finutss/views/widgets/sensor_widgets/add_sensor_row.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter/widgets.dart';
// import 'package:community_material_icon/community_material_icon.dart';
// import 'package:get/get.dart';

// class ConnectionDialog extends StatelessWidget {
//   final sensorController = Get.put(SensorController());
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SensorController>(builder: (controller) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
//         contentPadding: EdgeInsets.zero,
//         insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 48),
//         backgroundColor: Colors.white,
//         content: Container(
//             height: 680,
//             width: MediaQuery.of(context).size.width,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   size15,
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Center(child: headingWidget(title: 'Connection')),
//                       Align(
//                         alignment: Alignment.topRight,
//                         child: CircleAvatar(
//                           backgroundColor: backgroundSilverColor,
//                           child: IconButton(
//                               onPressed: () {
//                                 Get.back();
//                                 /*Get.back();
//                                   Get.back();*/
//                               },
//                               icon: Icon(
//                                 CommunityMaterialIcons.window_close,
//                                 color: darkGreyColor,
//                               )),
//                         ),
//                       ),
//                     ],
//                   ),
//                   size25,
//                   subHeadingWidget(title: "Connection Status"),
//                   size15,
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: Color(0xfff5f7fa),
//                     ),
//                     width: MediaQuery.of(context).size.width,
//                     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 14),
//                     child: Row(
//                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Image.asset(
//                           'assets/images/clock.png',
//                           scale: 1.5,
//                         ),
//                         size10,
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Row(
//                               children: [
//                                 Text(
//                                   'Speed',
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 size10,
//                                 Image.asset(
//                                   'assets/images/network_green.png',
//                                   scale: 1.5,
//                                 ),
//                               ],
//                             ),
//                             size5,
//                             Text(
//                               'XOSS-3279488',
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600),
//                             )
//                           ],
//                         ),
//                         size10,
//                         InkWell(
//                           onTap: () {
//                             // return controller.navigateToConnectTo();
//                             Get.dialog(ConnectionStatusDialog());
//                           },
//                           child: Container(
//                             // width: 64,
//                             // height: 60,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               color: Colors.white,
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 10, horizontal: 13),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                     'assets/images/bluetooth_off.png',
//                                     scale: 1.5,
//                                   ),
//                                   Text(
//                                     "OFF",
//                                     style: TextStyle(
//                                       color: Color(0xff41465c),
//                                       fontSize: 12,
//                                       /*fontFamily: "Montserrat",*/ fontWeight:
//                                           FontWeight.w500,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   size15,
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: Color(0xfff5f7fa),
//                     ),
//                     width: MediaQuery.of(context).size.width,
//                     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 14),
//                     child: Row(
//                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Image.asset(
//                               'assets/images/strength.png',
//                               scale: 1.5,
//                             ),
//                             size10,
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       'Cadence',
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                     size10,
//                                     Image.asset(
//                                       'assets/images/network_orange.png',
//                                       scale: 1.5,
//                                     ),
//                                   ],
//                                 ),
//                                 size5,
//                                 Text(
//                                   'XOSS-6946317',
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600),
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                         size10,
//                         Container(
//                           // width: 64,
//                           // height: 60,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: Colors.white,
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                                 vertical: 10, horizontal: 13),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Image.asset(
//                                   'assets/images/bluetooth_off.png',
//                                   scale: 1.5,
//                                 ),
//                                 Text(
//                                   "OFF",
//                                   style: TextStyle(
//                                     color: Color(0xff41465c),
//                                     fontSize: 12,
//                                     /*fontFamily: "Montserrat",*/ fontWeight:
//                                         FontWeight.w500,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   size15,
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: Color(0xfff5f7fa),
//                     ),
//                     width: MediaQuery.of(context).size.width,
//                     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 14),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             subHeadingWidget(title: 'Search'),
//                             Image.asset(
//                               'assets/images/exclamation.png',
//                               scale: 1.5,
//                             ),
//                           ],
//                         ),
//                         size15,
                        // RichText(
                        //     text: TextSpan(
                        //   text:
                        //       'Attemped to connect to the sensor. Please Roted the pedal to prepare the sensor with the connection.',
                        //   style: TextStyle(
                        //       color: Color(0xff7f8391),
                        //       fontSize: 15,
                        //       fontWeight: FontWeight.w300),
                        // )),
//                         size25,
//                         InkWell(
//                           onTap: () {},
//                           child: Container(
//                             width: MediaQuery.of(context).size.width,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               color: Colors.white,
//                             ),
//                             padding: EdgeInsets.symmetric(vertical: 15),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Image.asset(
//                                   'assets/images/rescan.png',
//                                   scale: 1.5,
//                                 ),
//                                 size10,
//                                 Text(
//                                   "RESCAN",
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: Color(0xffcdd5e9),
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   size15,
//                   addSensorRow(),
//                   size15,
//                 ],
//               ),
//             )),
//       );
//     });
//   }
// }
