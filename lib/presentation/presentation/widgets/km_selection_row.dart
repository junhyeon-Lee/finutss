import 'package:finutss/constants.dart';
import 'package:finutss/data/models/track.dart';
import 'package:finutss/domain/controller/map_controller.dart';
import 'package:finutss/presentation/screens/workout_screens/precaution_page.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget kmSelectionRow({required context, backgroundColor = colorBlue, Track? track}) {
  final MapController mapController = Get.put(MapController());
  var distance = track?.distance ?? 0;
  return Container(
    child: Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //         {'title': 'SHORT'.tr, 'text': '3.70', 'unitText': ' km'},
          // {'title': 'HALF'.tr, 'text': '6.78', 'unitText': ' min'},
          // {'title': 'FULL'.tr, 'text': '15.4', 'unitText': ' kcal'}
          // for (var data in homeController.kmSelectionList)
          _kmSelectionCard(
              context: context,
              title: 'SHORT'.tr,
              text: (distance * 0.25).toStringAsFixed(1),
              backgroundColor: backgroundColor,
              onTap: () {
                mapController.iskmShort = true;
                mapController.iskmHalf = false;
                mapController.iskmFull = false;
                Get.to(() => PrecautionsPage());
              }),
          _kmSelectionCard(
              context: context,
              title: 'HALF'.tr,
              unitText: 'Min',
              text: (distance * 0.5).toStringAsFixed(1),
              backgroundColor: backgroundColor,
              onTap: () {
                mapController.iskmShort = false;
                mapController.iskmHalf = true;
                mapController.iskmFull = false;
                Get.to(() => PrecautionsPage());
              }),
          _kmSelectionCard(
              context: context,
              unitText: 'kcal',
              title: 'FULL'.tr,
              text: (distance).toStringAsFixed(1),
              backgroundColor: backgroundColor,
              onTap: () {
                mapController.iskmShort = false;
                mapController.iskmHalf = false;
                mapController.iskmFull = true;
                Get.to(() => PrecautionsPage());
              }),
        ],
      ),
    ),
  );
}

Widget _kmSelectionCard(
    {title = '',
    required context,
    text = '',
    unitText = 'km',
    backgroundColor = colorBlue,
    required Null Function() onTap}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      child: Container(
        height: 48.h,
        width: MediaQuery.of(context).size.width / 4.3,
        decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(7)),
        child: Padding(
          padding: EdgeInsets.only(left: 10.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // size10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customText(
                    text: title,
                    fontColor: colorDarkGrey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  size10,
                  customText(
                    text: unitText,
                    fontColor: Color(0xffF5F7FA),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: customText(
                    text: text,
                    fontColor: Color(0xffF5F7FA),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )

              /*  customText(
                text: title,
                fontColor: colorDarkGrey,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  */ /* -------------------------------------------------------------------------- */ /*
                  */ /*                                    text                                    */ /*
                  */ /* -------------------------------------------------------------------------- */ /*
                  customText(
                    text: text,
                    fontColor: Color(0xffF5F7FA),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),

                  */ /* -------------------------------------------------------------------------- */ /*
                  */ /*                                  unit text                                 */ /*
                  */ /* -------------------------------------------------------------------------- */ /*
                  customText(
                    text: unitText,
                    fontColor: Color(0xffF5F7FA),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),*/
            ],
          ),
        ),
      ),
    ),
  );
}
