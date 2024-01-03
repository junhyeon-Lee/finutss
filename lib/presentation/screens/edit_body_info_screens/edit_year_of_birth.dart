import 'package:finutss/domain/controller/edit_body_info_controller.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_radio_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget editYearOfBirthWidget() {
  final EditBodyInfoController editBodyInfoController = Get.put(EditBodyInfoController());
  var index = 0;
  for (var i = 0; i < editBodyInfoController.addYearList.length; i++) {
    print("${editBodyInfoController.addYearList[i].toString()} ${editBodyInfoController.selectedYearOfBirth}");
    print("$i ${editBodyInfoController.addYearList[i] == editBodyInfoController.selectedYearOfBirth}");
    if (editBodyInfoController.addYearList[i].toString() == editBodyInfoController.selectedYearOfBirth) {
      print(editBodyInfoController.addYearList[i]);
      index = i;
      break;
    }
  }
  print("i ${editBodyInfoController.selectedYearOfBirth}");
  print("i $index");
  return Container(
    height: 340.h,
    child: GetBuilder<EditBodyInfoController>(
        init: EditBodyInfoController(),
        builder: (controller) {
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
                  scrollController: FixedExtentScrollController(initialItem: index),
                  onSelectedItemChanged: (index) {
                    controller.selectYearOfBirth('${editBodyInfoController.addYearList[index]}');
                    print(controller.selectedYearOfBirth);
                    var YearOfBirth = new DateTime(int.parse(controller.selectedYearOfBirth!));
                    print(YearOfBirth);
                  },
                  itemExtent: 43,
                  looping: true,
                  backgroundColor: Colors.transparent,
                  children: [
                    for (var index = 0; index < editBodyInfoController.addYearList.length; index++)
                      customRadioTile(
                        text: controller.selectedYearOfBirth == '$index'
                            ? '${editBodyInfoController.addYearList[index]}'
                            : '${editBodyInfoController.addYearList[index]}',
                        color: controller.selectedYearOfBirth == '$index' ? Colors.transparent : Colors.transparent,
                        textColor: controller.selectedYearOfBirth == '${editBodyInfoController.addYearList[index]}'
                            ? Colors.white
                            : colorWhitish,
                        width: double.infinity,
                        // height: 20.0,
                        onTap: () {},
                      )
                  ],
                ),
              ),
            ],
          );
        }),

    //   height: 340,
    //   child: ListView.builder(
    //       shrinkWrap: true,
    //       itemCount: editBodyInfoController.addYearList.length,
    //       itemBuilder: (context, index) {
    //         return customRadioTile(
    //           text: editBodyInfoController.selectedYearOfBirth == '$index'
    //               ? '${editBodyInfoController.addYearList[index]}'
    //               : '${editBodyInfoController.addYearList[index]}',
    //           color: editBodyInfoController.selectedYearOfBirth == '$index'
    //               ? blueColor
    //               : Colors.transparent,
    //           textColor: editBodyInfoController.selectedYearOfBirth == '$index'
    //               ? Colors.white
    //               : whitishColor,
    //           onTap: () {
    //             editBodyInfoController.selectYearOfBirth('$index');
    //           },
    //         );
    //       }),
  );
}

// import 'package:finutss/controller/edit_body_info_controller.dart';
// import 'package:finutss/views/screens/edit_body_info_screens/edit_height.dart';
// import 'package:finutss/views/widgets/common_widgets/constants.dart';
// import 'package:finutss/views/widgets/common_widgets/custom_button.dart';
// import 'package:finutss/views/widgets/common_widgets/custom_radio_tile.dart';
// import 'package:finutss/views/widgets/common_widgets/heading_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class EditYearOfBirth extends StatelessWidget {
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
//                   headingWidget(title: 'Year of Birth   '),
//                   size35,
//                   /* ---------------------------------- list ---------------------------------- */
//                   Container(
//                     height: 340,
//                     child: ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: controller.addYearList.length,
//                         itemBuilder: (context, index) {
//                           return customRadioTile(
//                             text: controller.selectedYearOfBirth == '$index'
//                                 ? '${controller.addYearList[index]}'
//                                 : '${controller.addYearList[index]}',
//                             color: controller.selectedYearOfBirth == '$index'
//                                 ? blueColor
//                                 : Colors.transparent,
//                             textColor:
//                                 controller.selectedYearOfBirth == '$index'
//                                     ? Colors.white
//                                     : whitishColor,
//                             onTap: () {
//                               controller.selectYearOfBirth('$index');
//                             },
//                           );
//                         }),
//                   ),
//                   SizedBox(
//                     height: 60,
//                   ),
//                   /* ---------------------------------- text ---------------------------------- */
//                   Text(
//                     "If you have selected Your Birth Year, Please Press Next.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Color(0xff7f8391),
//                       fontSize: 14,
//                       fontFamily: "Montserrat",
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   size15,
//                   Text(
//                     "X  Birthday year is not used except customized health care records and suggested purposes.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Color(0xfff73a6b),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   size30,
//                   /* --------------------------------- buttons -------------------------------- */
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
//                             textColor: controller.selectedYearOfBirth == null
//                                 ? lightSilverColor
//                                 : Colors.white,
//                             textSize: 16,
//                             height: 48,
//                             fontWeight: FontWeight.w700,
//                             color: controller.selectedYearOfBirth == null
//                                 ? Colors.white
//                                 : blueColor,
//                             onTapFunction: () {
//                               controller.selectedYearOfBirth != null
//                                   ? Get.to(EditHeight(),
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
