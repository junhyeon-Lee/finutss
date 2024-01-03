// import 'package:finutss/controller/sensor_controller.dart';
// import 'package:finutss/views/widgets/common_widgets/constants.dart';
// import 'package:finutss/views/widgets/common_widgets/custom_button.dart';
// import 'package:finutss/views/widgets/common_widgets/heading_widget.dart';
// import 'package:finutss/views/widgets/sensor_widgets/add_sensor_row.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter/widgets.dart';
// import 'package:community_material_icon/community_material_icon.dart';
// import 'package:get/get.dart';

// class ConnectionStatusDialog extends StatelessWidget {
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
//             // height: 900,
//             width: MediaQuery.of(context).size.width,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     size15,
//                     Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         Center(child: headingWidget(title: 'Connection')),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: CircleAvatar(
//                             backgroundColor: backgroundSilverColor,
//                             child: IconButton(
//                                 onPressed: () {
//                                   Get.back();
//                                   /*Get.back();
//                                     Get.back();*/
//                                 },
//                                 icon: Icon(
//                                   CommunityMaterialIcons.window_close,
//                                   color: darkGreyColor,
//                                 )),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         size25,
//                         subHeadingWidget(title: "Connection Status"),
//                         size15,
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: Color(0xfff5f7fa),
//                           ),
//                           width: MediaQuery.of(context).size.width,
//                           padding: EdgeInsets.symmetric(
//                               vertical: 15, horizontal: 14),
//                           child: Text(
//                             "No sensor are connected",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Color(0xff7f8391),
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                         size15,
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: Color(0xfff5f7fa),
//                           ),
//                           width: MediaQuery.of(context).size.width,
//                           padding: EdgeInsets.symmetric(
//                               vertical: 15, horizontal: 14),
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   subHeadingWidget(title: 'Search'),
//                                   Image.asset(
//                                     'assets/images/exclamation.png',
//                                     scale: 1.5,
//                                   ),
//                                 ],
//                               ),
//                               size15,
//                               RichText(
//                                   text: TextSpan(
//                                 text:
//                                     'Attemped to connect to the sensor. Please Roted the pedal to prepare the sensor with the connection.',
//                                 style: TextStyle(
//                                     color: Color(0xff7f8391),
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w300),
//                               )),
//                               size15,
//                               connectToTile(
//                                   text: 'XOSS-6946317',
//                                   textColor: Color(0xff303443),
//                                   scale: 1,
//                                   networkImage:
//                                       'assets/images/network_green.png',
//                                   buttonOnTap: () {
//                                     Get.back();
//                                     // controller.navigateToConnect = false;
//                                     // controller.update();
//                                   }),
//                               connectToTile(
//                                   text: "cycplus S3 12458",
//                                   networkImage:
//                                       'assets/images/network_semi_orange.png',
//                                   buttonOnTap: () {
//                                     Get.back();
//                                     // controller.navigateToConnect = false;
//                                     // controller.update();
//                                   }),
//                               connectToTile(
//                                   text: 'cycplus S3 12458',
//                                   networkImage:
//                                       'assets/images/network_gray.png',
//                                   buttonOnTap: () {
//                                     Get.back();
//                                     // controller.navigateToConnect = false;
//                                     // controller.update();
//                                   }),
//                               connectToTile(
//                                   text: 'cycplus S3 12458',
//                                   networkImage:
//                                       'assets/images/network_semi_green.png',
//                                   buttonOnTap: () {
//                                     Get.back();
//                                     // controller.navigateToConnect = false;
//                                     // controller.update();
//                                   }),
//                               connectToTile(
//                                   text: 'cycplus S3 12458',
//                                   networkImage:
//                                       'assets/images/network_semi_red.png',
//                                   buttonOnTap: () {
//                                     Get.back();
//                                     // controller.navigateToConnect = false;
//                                     // controller.update();
//                                   }),
//                               size25,
//                               InkWell(
//                                 onTap: () {},
//                                 child: Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(12),
//                                     color: Color(0xff41465c),
//                                   ),
//                                   padding: EdgeInsets.symmetric(vertical: 15),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Image.asset(
//                                         'assets/images/rescan.png',
//                                         scale: 1.5,
//                                       ),
//                                       size10,
//                                       Text(
//                                         "RESCAN",
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           color: Color(0xffcdd5e9),
//                                           fontSize: 16,
//                                           // fontFamily: "Montserrat",
//                                           fontWeight: FontWeight.w700,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         size15,
//                         addSensorRow(),
//                       ],
//                     ),
//                     size15,
//                   ],
//                 ),
//               ),
//             )),
//       );
//     });
//   }

//   connectToTile({
//     String text = 'XOSS-6946317',
//     Color textColor = const Color(0xff7f8391),
//     String networkImage = 'assets/images/network_green.png',
//     double scale = 1.5,
//     Function buttonOnTap,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Color(0xffcdd5e9),
//           width: 0.50,
//         ),
//       ),
//       padding: EdgeInsets.symmetric(
//         horizontal: 12,
//         vertical: 9,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Flexible(
//             child: Text(
//               text,
//               style: TextStyle(
//                 color: textColor,
//                 fontSize: 14,
//                 // fontFamily: "Montserrat",
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Row(
//             children: [
//               Image.asset(
//                 networkImage,
//                 scale: scale,
//               ),
//               SizedBox(
//                 width: 2,
//               ),
//               customButton(
//                 text: 'CONNECT',
//                 width: 80,
//                 height: 34,
//                 onTapFunction: buttonOnTap,
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
