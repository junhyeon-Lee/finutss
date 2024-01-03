import 'package:finutss/domain/controller/edit_body_info_controller.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_radio_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget editWeightWidget() {
  return Container(
    height: 340,
    child: GetBuilder<EditBodyInfoController>(builder: (editBodyInfoController) {
      var selectIndex =
          editBodyInfoController.addWeightList.indexWhere((item) => '$item' == editBodyInfoController.selectedWeight);
      return Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 9.w),
            child: Container(
              height: 43,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // border: Border.all(color: borderColor,width: 1),
                color: colorBlue,
              ),
            ),
          ),
          Container(
            child: CupertinoPicker(
              onSelectedItemChanged: (index) {
                editBodyInfoController.selectWeight('${editBodyInfoController.addWeightList[index]}');
              },
              itemExtent: 43,
              looping: true,
              backgroundColor: Colors.transparent,
              children: editBodyInfoController.addWeightList
                  .map((item) => customRadioTile(
                      text: editBodyInfoController.selectedWeight == '$item' ? '$item kg' : '$item',
                      color: editBodyInfoController.selectedWeight == '$item' ? Colors.transparent : Colors.transparent,
                      textColor: editBodyInfoController.selectedWeight == '$item' ? Colors.white : colorWhitish))
                  .toList(),
              scrollController: FixedExtentScrollController(initialItem: selectIndex),
            ),
          ),
        ],
      );
    }),

    //  ListView.builder(
    //     shrinkWrap: true,
    //     itemCount: editBodyInfoController.addWeightList.length,
    //     itemBuilder: (context, index) {
    //       return customRadioTile(
    //         text: editBodyInfoController.selectedWeight == '$index'
    //             ? '${editBodyInfoController.addWeightList[index]} kg'
    //             : '${editBodyInfoController.addWeightList[index]}',
    //         color: editBodyInfoController.selectedWeight == '$index'
    //             ? blueColor
    //             : Colors.transparent,
    //         textColor: editBodyInfoController.selectedWeight == '$index'
    //             ? Colors.white
    //             : whitishColor,
    //         onTap: () {
    //           editBodyInfoController.selectWeight('$index');
    //         },
    //       );
    //     }),
  );
}

// import 'package:finutss/controller/edit_body_info_controller.dart';
// import 'package:finutss/views/screens/edit_body_info_screens/basic_body_info.dart';
// import 'package:finutss/views/widgets/common_widgets/constants.dart';
// import 'package:finutss/views/widgets/common_widgets/custom_button.dart';
// import 'package:finutss/views/widgets/common_widgets/custom_radio_tile.dart';
// import 'package:finutss/views/widgets/common_widgets/heading_widget.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class EditWeight extends StatelessWidget {
//   final editBodyInfoController = Get.put(EditBodyInfoController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundSilverColor,
//       body: GetBuilder<EditBodyInfoController>(builder: (controller) {
//         return SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 40),
//             child: Container(
//               width: double.infinity,
//               padding: EdgeInsets.symmetric(vertical: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   size30,
//                   headingWidget(title: 'Weight'),
//                   size35,
//                   /* ---------------------------------- list ---------------------------------- */
//                   Container(
//                     height: 340,
//                     child: ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: controller.addWeightList.length,
//                         itemBuilder: (context, index) {
//                           return customRadioTile(
//                             text: controller.selectedWeight == '$index'
//                                 ? '${controller.addWeightList[index]} kg'
//                                 : '${controller.addWeightList[index]}',
//                             color: controller.selectedWeight == '$index'
//                                 ? blueColor
//                                 : Colors.transparent,
//                             textColor: controller.selectedWeight == '$index'
//                                 ? Colors.white
//                                 : whitishColor,
//                             onTap: () {
//                               controller.selectWeight('$index');
//                             },
//                           );
//                         }),
//                   ),
//                   size40,
//                   /* ---------------------------------- text ---------------------------------- */
//                   Text(
//                     "Record Weight, Sweep up and down the numbers above.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: whitishColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   size30,
//                   Text(
//                     "X  It is recommended to record Weight Periodically for exercise habits.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Color(0xfff73a6b),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   size30,
//                   /* --------------------------------- button --------------------------------- */
//                   Row(
//                     children: [
//                       Expanded(
//                         child: customButton(
//                             text: controller.isNavigatedFromEditBodyInfo
//                                 ? 'PREV'
//                                 : 'CANCEL',
//                             textSize: 16,
//                             height: 48,
//                             textColor: Color(0xff303443),
//                             color: Colors.transparent,
//                             fontWeight: FontWeight.w700,
//                             borderColor: Colors.grey,
//                             onTapFunction: () {
//                               return Get.back();
//                             }),
//                       ),
//                       size10,
//                       Expanded(
//                         child: customButton(
//                             text: controller.isNavigatedFromEditBodyInfo
//                                 ? 'NEXT'
//                                 : 'RECORD',
//                             textColor: controller.selectedWeight == null
//                                 ? lightSilverColor
//                                 : Colors.white,
//                             textSize: 16,
//                             height: 48,
//                             fontWeight: FontWeight.w700,
//                             color: controller.selectedWeight == null
//                                 ? Colors.white
//                                 : blueColor,
//                             onTapFunction: () {
//                               controller.selectedWeight != null
// ? controller.isNavigatedFromEditBodyInfo
//     ? Get.to(BasicBodyInfo(),
//         preventDuplicates: false)
//     : Get.back()
//                                   : print('height not selected');
//                               controller.selectedWeight != null
//                                   ? controller.calculateBMI()
//                                   : print('height not selected');
//                             }),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
