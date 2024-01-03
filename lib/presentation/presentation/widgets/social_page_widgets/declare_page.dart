// import 'package:finutss/controller/social_controller.dart';
// import 'package:finutss/views/widgets/common_widgets/appbars/simple_appbar.dart';
// import 'package:finutss/views/widgets/common_widgets/constants.dart';
// import 'package:finutss/views/widgets/common_widgets/custom_text.dart';
// import 'package:finutss/views/widgets/social_page_widgets/declare_reason_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class DeclarePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: simpleAppBar(
//         text: "Declare",
//         automaticallyImplyLeading: true,
//         actions: <Widget>[
//           IconButton(
//             onPressed: () {
//               // Get.to(FindFriends());
//             },
//             icon: Icon(
//               Icons.online_prediction,
//               color: Color(0xFF3BCCE1),
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               // Get.to(FindFriends());
//             },
//             icon: Icon(
//               Icons.notifications,
//               color: Color(0xFF3BCCE1),
//             ),
//           ),
//         ],
//       ),
//       body: GetBuilder<SocialController>(
//         init: SocialController(),
//         builder: (socialController) {
//           return Container(
//             height: Get.height,
//             width: Get.width,
//             color: Color(0xFFF5F7FA),
//             child: Column(
//               children: [
//                 size15,
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: Color(0xFFFFFFFF),
//                     ),
//                     height: 382,
//                     width: 342,
//                     // color: Color(0xFFFFFFFF),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.all(8.r),
//                           child: Row(
//                             children: [
//                               customText(
//                                 text: "What made report it?",
//                                 fontColor: Color(0xFF303443),
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 20,
//                               )
//                             ],
//                           ),
//                         ),
//                         size20,
//                         options(0),
//                         options(1),
//                         options(2),
//                         options(3),
//                         options(4),
//                         options(5),
//                       ],
//                     ),
//                   ),
//                 ),
//                 size20,
//                 InkWell(
//                   onTap: () {
//                     Get.to(DeclareReasonsPage());
//                   },
//                   child: Container(
//                     height: 48,
//                     width: 343,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: Color(0xFF3BCCE1),
//                     ),
//                     child: Center(
//                       child: customText(
//                         text: "Next",
//                         fontColor: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget options(int optionIndex) {
//     SocialController socialController = Get.find();
//     return Column(
//       children: [
//         Row(
//           children: [
//             new Radio(
//               value: optionIndex,
//               groupValue: socialController.radioValue,
//               onChanged: socialController.handleRadioValueChange,
//             ),
//             customText(
//                 text: socialController.declareOptions[optionIndex],
//                 fontColor: Color(0xFF7F8391),
//                 fontSize: 14,
//                 fontWeight: FontWeight.normal),
//           ],
//         ),
//         Container(
//           height: 1,
//           width: Get.width / 1.2,
//           color: Color(0xFF7F8391),
//         ),
//       ],
//     );
//   }
// }
