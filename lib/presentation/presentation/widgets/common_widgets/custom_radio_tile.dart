import 'package:flutter/material.dart';
import 'custom_button.dart';

Widget customRadioTile({
  onTap,
  text = '',
  color = Colors.transparent,
  width = double.infinity,
  height = 43.0,
  textColor = const Color(0xff7f8391),
  fontWeight = FontWeight.w500,
  fontSize = 20.0,
}) {
  return Row(
    children: [
      Expanded(
        child: customButton(
            onTapFunction: onTap,
            text: text,
            color: color,
            // width: width,
            height: height,
            textColor: textColor,
            fontWeight: fontWeight,
            textSize: fontSize),
      ),
    ],
  );
}
