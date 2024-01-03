// import 'package:finutss/controller/social_controller.dart';
// import 'package:finutss/views/widgets/common_widgets/appbars/simple_appbar.dart';
// import 'package:finutss/views/widgets/common_widgets/constants.dart';
// import 'package:finutss/views/widgets/common_widgets/custom_text.dart';
// import 'package:finutss/views/widgets/dialogs/send_report.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class DeclareReasonsPage extends StatelessWidget {
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
//                 Padding(
//                   padding: EdgeInsets.all(16.r),
//                   child: customText(
//                     text:
//                         "Could you tell me more about the situation for more smooth sanctions? (Optional)",
//                     fontColor: Color(0xFF303443),
//                     fontSize: 16,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),
//                 Container(
//                   height: 240,
//                   width: 343,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: Colors.white,
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(8.r),
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                       ),
//                       minLines: 10,
//                       maxLines: 12,
//                       maxLength: 60,
//                     ),
//                   ),
//                 ),
//                 size20,
//                 InkWell(
//                   onTap: () {
//                     Get.dialog(SendReport());
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
//                         text: "Send",
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
// }
