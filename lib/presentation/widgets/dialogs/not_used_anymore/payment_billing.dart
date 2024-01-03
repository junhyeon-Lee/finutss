// import 'package:finutss/views/widgets/dialogs/settings_dialogs/payment_unsubscribe_dialog.dart';
// import 'package:finutss/views/widgets/dialogs/social_dialogs/confirm_block_dialog.dart';
// import 'package:finutss/views/screens/social_pages/other_user_profile_page.dart';
// import 'package:finutss/views/widgets/common_widgets/constants.dart';
// import 'package:finutss/views/widgets/common_widgets/custom_button.dart';
// import 'package:finutss/views/widgets/common_widgets/custom_text.dart';
// import 'package:finutss/views/widgets/common_widgets/heading_widget.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:community_material_icon/community_material_icon.dart';
// import 'package:get/get.dart';

// // ignore: must_be_immutable
// class PaymentBilling extends StatelessWidget {
//   String fromDate, toDate;
//   PaymentBilling({
//     this.fromDate = "-/-/-",
//     this.toDate = "-/-/-",
//   });
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
//       contentPadding: EdgeInsets.zero,
//       backgroundColor: Colors.white,
//       content: Container(
//           height: Get.height,
//           width: Get.width,
//           child: Padding(
//             padding: EdgeInsets.all(17.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   size10,
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       headingWidget(title: 'Payment Info', size: 16.0),
//                       // size50,
//                       size10,
//                       CircleAvatar(
//                         backgroundColor: backgroundSilverColor,
//                         child: IconButton(
//                             onPressed: () {
//                               Get.off(OtherUserProfilePage());
//                             },
//                             icon: Icon(
//                               CommunityMaterialIcons.window_close,
//                               color: darkGreyColor,
//                             )),
//                       ),
//                     ],
//                   ),
//                   size30,
//                   Center(
//                     child: Container(
//                       height: 387,
//                       width: Get.width,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15.r),
//                         color: Color(0xFFF5F7FA),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             customText(
//                               text: "Galaxy Flip 3 Promotion",
//                               fontColor: Color(0xFF303443),
//                               fontSize: 20,
//                               fontWeight: FontWeight.w600,
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(top: 16),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   customText(
//                                     text: "Period: ",
//                                     fontColor: Color(0xFF303443),
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                   customText(
//                                     text: "$fromDate  to  $toDate",
//                                     fontColor: Color(0xFF7F8391),
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(top: 3),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   customText(
//                                     text: "Next payment Date: ",
//                                     fontColor: Color(0xFF303443),
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                   customText(
//                                     text: "$toDate",
//                                     fontColor: Color(0xFF7F8391),
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(top: 14.h),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(
//                                     color: Color(0xffCDD5E9),
//                                   ),
//                                   color: Colors.white,
//                                 ),
//                                 child: SizedBox(
//                                   height: 54,
//                                   child: Padding(
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal: 16,
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         customText(
//                                           text: "Price",
//                                           fontColor: Color(0xFF7F8391),
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 16,
//                                         ),
//                                         customText(
//                                           text: "W29.700",
//                                           fontColor: Color(0xFF303443),
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 16,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(top: 14.h),
//                               child: customText(
//                                 text: "Discount",
//                                 fontColor: Color(0xFF303443),
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(top: 12),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   customText(
//                                     text: "Galaxy Flip 3 Promo",
//                                     fontColor: Color(0xFF303443),
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                   customText(
//                                     text: "(-)",
//                                     fontColor: Color(0xFF303443),
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                   customText(
//                                     text: "W29,700",
//                                     fontColor: Color(0xFF7F8391),
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                 vertical: 14,
//                               ),
//                               child: Container(
//                                 height: 1,
//                                 width: Get.width,
//                                 color: Color(0xFFCDD5E9),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(top: 14.h),
//                               child: customText(
//                                 text: "Total Payment",
//                                 fontColor: Color(0xFF303443),
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(top: 12),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   customText(
//                                     text: "L (KAKAO Pay) OF!",
//                                     fontColor: Color(0xFF303443),
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                   customText(
//                                     text: "W29,700",
//                                     fontColor: Color(0xFF7F8391),
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Center(
//                               child: Padding(
//                                 padding: EdgeInsets.only(top: 14.h),
//                                 child: customText(
//                                   text:
//                                       "It will be automatically paid after the subscription period ends.",
//                                   fontColor: Color(0xFF7F8391),
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   size10,
//                   Center(
//                     child: Container(
//                         height: 200,
//                         width: Get.width,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15.r),
//                           color: Color(0xFFF5F7FA),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                             vertical: 20,
//                             horizontal: 16,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               customText(
//                                 text: "Pay With",
//                                 fontColor: Color(0xFF303443),
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                               size10,
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   paymentButton(
//                                       topRight: 0.0, bottomRight: 0.0),
//                                   divider(),
//                                   paymentButton(topLeft: 0.0, bottomLeft: 0.0)
//                                 ],
//                               ),
//                               size10,
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   paymentButton(
//                                       topRight: 0.0, bottomRight: 0.0),
//                                   divider(),
//                                   paymentButton(topLeft: 0.0, bottomLeft: 0.0)
//                                 ],
//                               )
//                             ],
//                           ),
//                         )),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       vertical: 16,
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(14.0),
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(bottom: 10.h),
//                             child: customText(
//                               text:
//                                   "1. Subscription payment will be made on the last day of the subscription period, and the subscription period will be automatically renewed after payment.",
//                               fontSize: 14,
//                               fontColor: Color(0xFF7F8391),
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(bottom: 10.h),
//                             child: customText(
//                               text:
//                                   "2. lf you want to stop renewing your subscription, you must cancle your subscription a day before the end of the  subscription period.",
//                               fontSize: 14,
//                               fontColor: Color(0xFF7F8391),
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(bottom: 10.h),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   width: 30,
//                                   child:
//                                       Checkbox(value: false, onChanged: null),
//                                 ),
//                                 Expanded(
//                                   child: Container(
//                                     width: 270,
//                                     child: customText(
//                                       // textAlign: TextAlign.start,
//                                       text:
//                                           "I checked the product information such as price, contents, cancellation refund, and income deduction policy, and | agree with it.",
//                                       fontSize: 14,
//                                       fontColor: Color(0xFF7F8391),
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: customButton(
//                             onTapFunction: () {
//                               Get.dialog(PaymentUnsubscribeDialog());
//                             },
//                             radius: 16,
//                             height: 48,
//                             text: 'Payment',
//                             fontWeight: FontWeight.w700,
//                             textSize: 16,
//                             color: Color(0xFF3BCCE1)),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           )),
//     );
//   }

//   Widget paymentButton({
//     topLeft = 15.0,
//     bottomLeft = 15.0,
//     topRight = 15.0,
//     bottomRight = 15.0,
//     imageIcon = "assets/images/social_accounts/apple.png",
//     iconName = "Bank Example",
//     function,
//   }) {
//     return Expanded(
//       child: InkWell(
//         onTap: function,
//         child: Container(
//           height: 59,
//           // width: 120,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(bottomLeft),
//               topLeft: Radius.circular(topLeft),
//               topRight: Radius.circular(topRight),
//               bottomRight: Radius.circular(bottomRight),
//             ),
//             color: Colors.white,
//           ),
//           child: Row(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(8.r),
//                 child: Container(
//                   height: 15,
//                   width: 15,
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                         fit: BoxFit.fill,
//                         image: AssetImage(imageIcon),
//                       ),
//                       borderRadius: BorderRadius.circular(15.r),
//                       color: Colors.white),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   height: 30,
//                   child: customText(
//                     text: iconName,
//                     fontColor: Color(0XFF303443),
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget divider() {
//     return Container(
//       height: 59,
//       width: 1,
//       color: Color(0xFFCDD5E9),
//     );
//   }
// }
