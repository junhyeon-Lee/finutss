import 'package:community_material_icon/community_material_icon.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/edit_body_info_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/dialogs/record_dialogs/delete_record_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class BodyInfoScreen extends StatelessWidget {
  final editBodyInfoController = Get.put(EditBodyInfoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundSilver,
      appBar: simpleAppBar(
        automaticallyImplyLeading: true,
        text: 'BODY_INFO'.tr,
        actions: [
          IconButton(
            onPressed: () {
              editBodyInfoController.onEditBodyInfoIconPressed();
            },
            padding: EdgeInsets.zero,
            icon: Icon(
              CommunityMaterialIcons.square_edit_outline,
              color: colorBlue,
              size: 25,
            ),
          ),
        ],
      ) as PreferredSizeWidget?,
      body: GetBuilder<AuthController>(builder: (authController) {
        return GetBuilder<EditBodyInfoController>(
            builder: (editBodyInfoController) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  size15,

                  ///TODO user?.usersDetails
                  /*
                  viewBodyInfo(
                    gender: '${authController.user != null ? authController.user?.usersDetails.sex ?? "" : ""}'.tr,
                    yearOfBirth:
                        '${authController.user != null ?  DateFormat('y').format(authController.user?.birthDate as DateTime) : ""}',
                    height: '${authController.user != null ? authController.user?.usersDetails.height ?? 0 : 0} cm',
                    weight: '${authController.user != null ? authController.user?.usersDetails.weight ?? 0 : 0} kg',
                    bmi: "${authController.userBMI}",
                    isButton: true,
                  ),

                   */
                  size15,
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Colors.white),
                    // height: 40,
                    child: Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15))),
                          color: colorLightGrey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(14.w, 10.h, 0, 10.h),
                                child: Text(
                                  'WEIGHT_RECORD'.tr,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        size15,
                        Container(
                          height: 90,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (var data
                                  in editBodyInfoController.weightRecordList)
                                _weightRecordBox(
                                  backgroundColor: data['backgroundColor'],
                                  topText: data['topText'],
                                  midText: data['midText'],
                                  bottomText: data['bottomText'],
                                  bottomColor: data['botttomColor'],
                                  midColor: data['midColor'],
                                  icon: data['icon'],
                                )
                            ],
                          ),
                        ),
                        size20,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      }),
    );
  }

  _weightRecordBox(
      {backgroundColor = colorBackgroundSilver,
      String topText = '',
      String midText = '',
      String bottomText = '',
      midColor = colorBlue,
      bottomColor = colorPink,
      icon}) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: InkWell(
        onTap: () {
          Get.dialog(
            DeleteRecordDialog(
                title: 'NOTICE'.tr,
                description: 'RECORD_DELETE_WARNING_GUIDE'.tr,
                callback: () {
                  // Bloc().queryMutate(WorkOutQueries.REMOVE_WORKOUT, {
                  //   "id" :
                  // });
                }),
          );
        },
        child: Container(
          width: 65,
          height: 80,
          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              size10,
              customText(
                text: topText,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              size10,
              customText(
                  text: midText,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontColor: midColor),
              size10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: bottomColor,
                    size: 15,
                  ),
                  customText(
                      text: bottomText,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      fontColor: bottomColor),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
