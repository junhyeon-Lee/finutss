import 'package:finutss/domain/controller/edit_body_info_controller.dart';
import 'package:finutss/presentation/widgets/view_body_info_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget basicBodyInfoWidget() {
  final EditBodyInfoController editBodyInfoController = Get.put(EditBodyInfoController());
  return Container(
    height: 340,
    child: viewBodyInfo(
        gender: '${editBodyInfoController.gender}',
        yearOfBirth: '${editBodyInfoController.selectedYearOfBirth}',
        height: '${editBodyInfoController.selectedHeight} cm',
        weight: '${editBodyInfoController.selectedWeight} kg',
        bmi: "${editBodyInfoController.bmi}"
            .substring(0, "${editBodyInfoController.bmi}".indexOf(".") + 2) /*controller.bmi*/,
        width: editBodyInfoController.bmiSliderValue),
  );
}





// import 'package:finutss/controller/edit_body_info_controller.dart';
// import 'package:finutss/views/screens/user_record_screens/body_info_screen.dart';
// import 'package:finutss/views/widgets/common_widgets/constants.dart';
// import 'package:finutss/views/widgets/common_widgets/custom_button.dart';
// import 'package:finutss/views/widgets/common_widgets/heading_widget.dart';
// import 'package:finutss/views/widgets/view_body_info_container.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class BasicBodyInfo extends StatelessWidget {
//   final editBodyInfoController = Get.put(EditBodyInfoController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundSilverColor,
//       body: GetBuilder<EditBodyInfoController>(builder: (controller) {
//         return SingleChildScrollView(
//           child: viewBodyInfo(
//               gender: '${controller.gender}',
//               yearOfBirth: '${controller.selectedYearOfBirth}',
//               height: '${controller.selectedHeight} cm',
//               weight: '${controller.selectedWeight} kg',
//               bmi: "${controller.bmi}".substring(
//                   0, "${controller.bmi}".indexOf(".") + 2) /*controller.bmi*/,
//               width: controller.bmiSliderValue),
//         );
//       }),
//     );
//   }

//   viewBodyInfo({gender, yearOfBirth, height, weight, bmi, width}) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15.r),
//         color: Colors.white,
//       ),
//       padding: EdgeInsets.only(bottom: 20),
//       child: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//                 color: lightGreyColor,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(15),
//                   topRight: Radius.circular(15),
//                 )),
//             padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//             child: Text(
//               "Basic body info",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),
//           Row(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: 14.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     size15,
//                     customText(
//                       text: "Gender :",
//                       fontColor: whitishColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       // fontFamily: 'Montserrat-Medium.ttf'
//                     ),
//                     size15,
//                     customText(
//                       text: "Year of  birth :",
//                       fontColor: whitishColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       // fontFamily: 'Montserrat-Medium.ttf'
//                     ),
//                     size15,
//                     customText(
//                       text: "Height :",
//                       fontColor: whitishColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       // fontFamily: 'Montserrat-Medium.ttf'
//                     ),
//                     size15,
//                     customText(
//                       text: "Weight :",
//                       fontColor: whitishColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       // fontFamily: 'Montserrat-Medium.ttf'
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 14.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     size15,
//                     customText(
//                       text: gender,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       // fontFamily: 'Montserrat-Medium.ttf'
//                     ),
//                     size15,
//                     customText(
//                       text: '$yearOfBirth',
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       // fontFamily: 'Montserrat-Medium.ttf'
//                     ),
//                     size15,
//                     customText(
//                       text: "$height",
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       // fontFamily: 'Montserrat-Medium.ttf'
//                     ),
//                     size15,
//                     customText(
//                       text: "$weight",
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       // fontFamily: 'Montserrat-Medium.ttf'
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           size20,
//           Container(
//               color: lightGreyColor,
//               padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   customText(
//                       text: 'BMI',
//                       fontColor: Colors.white,
//                       fontWeight: FontWeight.w700),
//                   customText(
//                       text: '$bmi',
//                       fontColor: blueColor,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600),
//                 ],
//               )),
//           size15,
//           bmiSlider(width),
//         ],
//       ),
//     );
//   }
// }
