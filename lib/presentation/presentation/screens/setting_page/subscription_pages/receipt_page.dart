import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/rounded_decoration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

// ignore: must_be_immutable
class ReceiptPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundSilver,
      appBar: simpleAppBar(text: 'RECEIPT'.tr) as PreferredSizeWidget?,
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: roundedDecoration(),
                  child: Column(
                    children: [
                      /* ------------------------- heading line with logo ------------------------- */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                              text: 'RECEIPT'.tr, fontColor: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                          Expanded(
                            child: Center(
                              child: customText(
                                  text: 'FOR_STORAGE_BY_SUPPLIED_PERSON'.tr,
                                  fontColor: Color(0xff7F8391),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Image.asset(
                            'assets/images/small_logo.png',
                            height: 22.h,
                            width: 26.w,
                          )
                        ],
                      ),
                      size20,
                      /* -------------------------------------------------------------------------- */
                      /*                                    table                                   */
                      /* -------------------------------------------------------------------------- */
                      Container(
                          decoration: roundedDecoration(color: colorBackgroundSilver),
                          child: Table(
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            columnWidths: {1: FractionColumnWidth(.65)},
                            border: TableBorder(
                                horizontalInside: BorderSide(color: Color(0xff7F8391), width: .5),
                                verticalInside: BorderSide(color: Color(0xff7F8391), width: .5)),
                            children: [
                              tableRow('ORDER_NO'.tr, 'P314n-456-225-235'),
                              tableRow('DATE'.tr, '2021/12/25'),
                              tableRow('PRODUCT'.tr, '[Automatic Payment] Monthly subscription'),
                              tableRow('PRICE'.tr, 'w9,150'),
                              tableRow('COMPANY'.tr, '9iece co Ltd.'),
                            ],
                          )),
                      size15,
                      /* ----------------------------- company address ---------------------------- */
                      customText(
                          height: 1.5,
                          text: '$receiptDescription',
                          fontColor: Color(0xff7F8391),
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ],
                  ),
                ),
                size15,
                Row(
                  children: [
                    Image.asset(
                      'assets/images/logo_black_white.png',
                      height: 94.h,
                      width: 94.h,
                    ),
                    size15,
                    Expanded(
                      child: customText(
                          height: 1.5,
                          text: '$companyAddress',
                          fontColor: Color(0xff7F8391),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableRow tableRow(heading, value) {
    return TableRow(children: [
      Padding(
        padding: EdgeInsets.all(16.r),
        child: customText(text: '$heading', fontColor: Color(0xff7F8391), fontSize: 14, fontWeight: FontWeight.w500),
      ),
      Padding(
        padding: EdgeInsets.all(16.r),
        child:
            customText(height: 1.2, text: '$value', fontColor: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ]);
  }

  String companyAddress = 'COPYRIGHT'.tr;
  String receiptDescription = 'RECEIPT_USAGE_INFO'.tr;
}
