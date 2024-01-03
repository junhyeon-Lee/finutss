// import 'package:finutss/controller/edit_body_info_controller.dart';
// import 'package:finutss/views/widgets/common_widgets/constants.dart';
// import 'package:finutss/views/widgets/common_widgets/custom_radio_tile.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class Test extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      // body: GetBuilder<EditBodyInfoController>(
      //     init: EditBodyInfoController(),
      //     builder: (controller) {
      //       return Stack(
      //         alignment: Alignment.center,
      //         children: [
      //           Padding(
      //             padding: EdgeInsets.symmetric(horizontal: 9.w),
      //             child: Container(
      //               height: 43,
      //               width: double.infinity,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(12),
      //                 // border: Border.all(color: borderColor,width: 1),
      //                 color: blueColor,
      //               ),
      //             ),
      //           ),
      //           Container(
      //             child: CupertinoPicker(
      //               onSelectedItemChanged: (value) {
      //                 controller.selectYearOfBirth('$value');
      //                 print(controller.selectedYearOfBirth);
      //               },
      //               itemExtent: 43,
      //               looping: true,
      //               backgroundColor: Colors.transparent,
      //               children: [
      //                 for (var index = 0; index < 500; index++)
      //                   customRadioTile(
      //                     text:
      //                         controller.selectedYearOfBirth == index.toString()
      //                             ? '${index + 1}'
      //                             : '${index + 1}',
      //                     color:
      //                         controller.selectedYearOfBirth == index.toString()
      //                             ? Colors.transparent
      //                             : Colors.transparent,
      //                     textColor:
      //                         controller.selectedYearOfBirth == index.toString()
      //                             ? Colors.white
      //                             : whitishColor,
      //                     width: double.infinity,
      //                     // height: 20.0,
      //                     onTap: () {},
      //                   )
      //               ],
      //             ),
      //           ),
      //         ],
      //       );
      //     }),
//     );
//   }
// }
