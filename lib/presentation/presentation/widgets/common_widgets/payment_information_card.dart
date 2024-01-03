import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';

Widget paymentInformationCard({
  paymentType = "N/A",
  fromDate = "-/-/-",
  toDate = "-/-/-",
  duration = 'Monthly',
  subscriptionId = "1234-1234-1234-1234",
  foreGroundColor = Colors.grey,
  backGroundColor = Colors.black,
  function,
  useTickIcon = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      customText(
        text: '[$paymentType] $duration',
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          customText(
            text: "$fromDate   to   $toDate",
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontColor: Color(0xFF7F8391),
          ),
          // CircleAvatar(
          //   backgroundColor: !useTickIcon ? Color(0xffF73A6B).withOpacity(0.1) : Color(0xff14C664).withOpacity(0.1),
          //   radius: 20.r,
          //   child: IconButton(
          //       onPressed: function,
          //       padding: EdgeInsets.zero,
          //       icon: Icon(
          //         useTickIcon == false ? CommunityMaterialIcons.window_close : Icons.check,
          //         size: 24.r,
          //         color: !useTickIcon ? Color(0xffF73A6B) : Color(0xff14C664),
          //       )),
          // ),
        ],
      ),
      customText(
        text: subscriptionId,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontColor: Color(0xFF3BCCE1),
      ),
    ],
  );
}
