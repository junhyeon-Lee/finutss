import 'package:finutss/domain/controller/edit_body_info_controller.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_radio_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget editHeightWidget() {
  return Container(
    height: 340,
    child: GetBuilder<EditBodyInfoController>(builder: (editBodyInfoController) {
      var selectIndex =
          editBodyInfoController.addHeightList.indexWhere((item) => '$item' == editBodyInfoController.selectedHeight);
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
          CupertinoPicker(
            onSelectedItemChanged: (index) {
              editBodyInfoController.selectHeight('${editBodyInfoController.addHeightList[index]}');
            },
            itemExtent: 43,
            looping: true,
            backgroundColor: Colors.transparent,
            children: editBodyInfoController.addHeightList
                .map((item) => customRadioTile(
                    text: editBodyInfoController.selectedHeight == '$item' ? '$item cm' : '$item',
                    color: editBodyInfoController.selectedHeight == '$item' ? Colors.transparent : Colors.transparent,
                    textColor: editBodyInfoController.selectedHeight == '$item' ? Colors.white : colorWhitish))
                .toList(),
            scrollController: FixedExtentScrollController(initialItem: selectIndex),
          ),
        ],
      );
    }),

    // ListView.builder(
    //     shrinkWrap: true,
    //     itemCount: editBodyInfoController.addHeightList.length,
    //     itemBuilder: (context, index) {
    //       return customRadioTile(
    //         text: editBodyInfoController.selectedHeight == '$index'
    //             ? '      ${editBodyInfoController.addHeightList[index]} cm'
    //             : '${editBodyInfoController.addHeightList[index]}',
    //         color: editBodyInfoController.selectedHeight == '$index'
    //             ? blueColor
    //             : Colors.transparent,
    //         textColor: editBodyInfoController.selectedHeight == '$index'
    //             ? Colors.white
    //             : whitishColor,
    //         onTap: () {
    //           editBodyInfoController.selectHeight('$index');
    //         },
    //       );
    //     }),
  );
}

// import 'package:finutss/controller/edit_body_info_controller.dart';
// import 'package:finutss/views/screens/edit_body_info_screens/edit_weight.dart';

// import 'package:finutss/views/widgets/common_widgets/constants.dart';
// import 'package:finutss/views/widgets/common_widgets/custom_button.dart';
// import 'package:finutss/views/widgets/common_widgets/custom_radio_tile.dart';
// import 'package:finutss/views/widgets/common_widgets/heading_widget.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class EditHeight extends StatelessWidget {
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
//                   headingWidget(title: 'Height'),
//                   size35,
//                   /* ---------------------------------- list ---------------------------------- */
//                   Container(
//                     height: 340,
//                     child: ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: controller.addHeightList.length,
//                         itemBuilder: (context, index) {
//                           return customRadioTile(
//                             text: controller.selectedHeight == '$index'
//                                 ? '      ${controller.addHeightList[index]} cm'
//                                 : '${controller.addHeightList[index]}',
//                             color: controller.selectedHeight == '$index'
//                                 ? blueColor
//                                 : Colors.transparent,
//                             textColor: controller.selectedHeight == '$index'
//                                 ? Colors.white
//                                 : whitishColor,
//                             onTap: () {
//                               controller.selectHeight('$index');
//                             },
//                           );
//                         }),
//                   ),
//                   /* ---------------------------------- text ---------------------------------- */
//                   size40,
//                   Text(
//                     "Record Height, Sweep up and down the numbers above.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Color(0xff7f8391),
//                       fontSize: 14,
//                       fontFamily: "Montserrat",
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   size30,
//                   /* --------------------------------- button --------------------------------- */
//                   Row(
//                     children: [
//                       Expanded(
//                         child: customButton(
//                             text: 'PREV',
//                             textSize: 16,
//                             height: 48,
//                             textColor: darkGreyColor,
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
//                             text: 'NEXT',
//                             textColor: controller.selectedHeight == null
//                                 ? lightSilverColor
//                                 : Colors.white,
//                             textSize: 16,
//                             height: 48,
//                             fontWeight: FontWeight.w700,
//                             color: controller.selectedHeight == null
//                                 ? Colors.white
//                                 : blueColor,
//                             onTapFunction: () {
//                               controller.isNavigatedFromEditBodyInfo = true;
//                               controller.selectedHeight != null
//                                   ? Get.to(EditWeight(),
//                                       preventDuplicates: false)
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
