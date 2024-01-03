import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/edit_body_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget editGenderWidget() {
  final EditBodyInfoController editBodyInfoController = Get.put(EditBodyInfoController());
  final AuthController authController = Get.put(AuthController());
  return Container(
    height: 340,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            editBodyInfoController.gender = 'female';
            editBodyInfoController.editGender(authController.user?.userId);
          },
          child: editBodyInfoController.female.value
              ? Image.asset('assets/images/female_selected.png')
              : Image.asset('assets/images/female_unselected.png'),
        ),
        InkWell(
          onTap: () {
            editBodyInfoController.gender = 'male';
            /*controller.male = false;
                              controller.female = true;*/
            editBodyInfoController.editGender(authController.user?.userId);
          },
          child: editBodyInfoController.male.value
              ? Image.asset('assets/images/male_selected.png')
              : Image.asset('assets/images/male_unselected.png'),
        ),
      ],
    ),
  );
}

// import 'package:finutss/controller/edit_body_info_controller.dart';
// import 'package:finutss/views/screens/edit_body_info_screens/edit_year_of_birth.dart';
// import 'package:finutss/views/widgets/common_widgets/constants.dart';
// import 'package:finutss/views/widgets/common_widgets/custom_button.dart';
// import 'package:finutss/views/widgets/common_widgets/heading_widget.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class EditGender extends StatelessWidget {
//   final editBodyInfoController = Get.put(EditBodyInfoController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GetBuilder<EditBodyInfoController>(builder: (controller) {
//         return SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 40),
//             child: Container(
//               width: double.infinity,
//               padding: EdgeInsets.symmetric(vertical: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 // mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   size25,
//                   headingWidget(title: 'Gender'),
//                   size60,
//                   /* ---------------------------- gender selection ---------------------------- */
//                   // if(controller.gender == null)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       InkWell(
//                           onTap: () {
//                             controller.gender = 'Female';
//                             controller.editGender();
//                           },
//                           child: controller.female.value
//                               ? Image.asset('assets/images/female_selected.png')
//                               : Image.asset(
//                                   'assets/images/female_unselected.png')),
//                       InkWell(
//                           onTap: () {
//                             controller.gender = 'Male';
//                             /*controller.male = false;
//                             controller.female = true;*/
//                             controller.editGender();
//                           },
//                           child: controller.male.value
//                               ? Image.asset('assets/images/male_selected.png')
//                               : Image.asset(
//                                   'assets/images/male_unselected.png')),
//                     ],
//                   ),
//                   size35,
//                   Text(
//                     "If you are a ${controller.gender ?? 'Male'}, Please \n Press Next.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Color(0xff7f8391),
//                       fontSize: 14,
//                       fontFamily: "Montserrat",
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   size35,
//                   /* --------------------------------- button --------------------------------- */
//                   Row(
//                     children: [
//                       Expanded(
//                         child: customButton(
//                             text: 'CANCEL',
//                             textSize: 16,
//                             height: 48,
//                             textColor: Color(0xff303443),
//                             color: Colors.transparent,
//                             fontWeight: FontWeight.w700,
//                             borderColor: Colors.grey,
//                             onTapFunction: () {
//                               Get.back();
//                             }),
//                       ),
//                       size10,
//                       Expanded(
//                         child: customButton(
//                             text: 'NEXT',
//                             textColor: controller.gender == null
//                                 ? Color(0xffcdd5e9)
//                                 : Colors.white,
//                             textSize: 16,
//                             height: 48,
//                             fontWeight: FontWeight.w700,
//                             color: controller.gender == null
//                                 ? Colors.white
//                                 : Color(0xff3bcce1),
//                             onTapFunction: () {
//                               controller.gender != null
//                                   ? Get.to(EditYearOfBirth(),
//                                       preventDuplicates: false)
//                                   : print('gender not selected');
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
