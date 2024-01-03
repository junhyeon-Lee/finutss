// import 'package:finutss/views/screens/workout_screens/map_page.dart';
// import 'package:finutss/views/widgets/common_widgets/constants.dart';
// import 'package:finutss/views/widgets/common_widgets/custom_button.dart';
// import 'package:finutss/views/widgets/common_widgets/custom_text.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:community_material_icon/community_material_icon.dart';
// import 'package:get/get.dart';

// class PrecautionsDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       // shape: RoundedRectangleBorder(
//       //   borderRadius: BorderRadius.circular(15.r),
//       // ),
//       contentPadding: EdgeInsets.zero,
//       backgroundColor: Colors.white,
//       content: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.only(left: 16.w, right: 16.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               size10,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   customText(
//                       text: 'Precautions',
//                       fontColor: Color(0xff303443),
//                       fontSize: 24,
//                       fontWeight: FontWeight.w700),
//                   CircleAvatar(
//                     backgroundColor: backgroundSilverColor,
//                     child: IconButton(
//                         onPressed: () {
//                           Get.back();
//                         },
//                         icon: Icon(
//                           CommunityMaterialIcons.window_close,
//                           color: darkGreyColor,
//                         )),
//                   ),
//                 ],
//               ),
//               size20,
//               customText(
//                   text: 'Workout',
//                   fontColor: Color(0xff303443),
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold),
//               size10,
//               Divider(
//                 thickness: 2,
//                 color: Color(0xffCDD5E9),
//               ),
//               size15,
//               RichText(
//                   textAlign: TextAlign.left,
//                   text: TextSpan(
//                       style: TextStyle(
//                         height: 2,
//                         color: Color(0xff7F8391),
//                         fontSize: 14,
//                       ),
//                       children: [
//                         TextSpan(
//                           text:
//                               '1. We recommend you to warm up enough, such as stretching, before starting.',
//                         ),
//                         TextSpan(
//                           text:
//                               '\n2. If tt is applicable to the following, please consult with your doctor before using It: A person with weak basic physical strength, such as children and the elderly; A person recommended by a doctor to restrict exercise.People with underlying diseases such as heart disease,diabetes, high blood pressure, respiratory diseases, etc.Someone who Is pregnant or has the potential to be pregnant.',
//                         ),
//                         TextSpan(
//                           text:
//                               "\n3. If you feel any strong pain or discomfort during exercise, please stop exercising immediately.",
//                         ),
//                       ])),
//               size15,
//               customText(
//                   text: 'Community',
//                   fontColor: Color(0xff303443),
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold),
//               size10,
//               Divider(
//                 thickness: 2,
//                 color: Color(0xffCDD5E9),
//               ),
//               size15,
//               RichText(
//                   textAlign: TextAlign.left,
//                   text: TextSpan(
//                       style: TextStyle(
//                         height: 2,
//                         color: Color(0xff7F8391),
//                         fontSize: 14,
//                       ),
//                       children: [
//                         TextSpan(
//                           text:
//                               "Please refrain from violating public order or good customs and expressions that violate other people's rights. The full responsibility for the consequences of this action rests with the member himself.",
//                         ),
//                         TextSpan(
//                           text:
//                               '\nUsers who violate your rights can send their message to it, please report.',
//                         ),
//                         TextSpan(
//                           text: "\nFor more information, check ",
//                         ),
//                         TextSpan(
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                           text: "Community Management Policies.",
//                         ),
//                       ])),
//               size15,
//               Row(
//                 children: [
//                   Expanded(
//                     child: customButton(
//                         onTapFunction: () {
//                           Get.to(() => MapPage());
//                         },
//                         height: 48,
//                         radius: 15,
//                         color: blueColor,
//                         text: "START NOW",
//                         textColor: Colors.white,
//                         textSize: 16),
//                   ),
//                 ],
//               ),
//               size30,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
