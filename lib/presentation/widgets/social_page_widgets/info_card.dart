import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget infoCard({header = "...", footer = "...", image = "", unitText = ""}) {
  return Expanded(
    flex: 1,
    child: Column(
      children: [
        header != ""
            ? customText(
                text: header,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontColor: Color(0xFF303443),
              )
            : Container(),
        size5,
        Container(
          height: 48.h,
          width: 48.w,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/$image'),
            ),
          ),
        ),
        customText(
          text: footer,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontColor: Color(0xFF303443),
        ),
        customText(
          text: unitText,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          fontColor: Color(0xFF303443),
        ),
      ],
    ),
  );
}
