import 'package:finutss/constants.dart';
import 'package:flutter/material.dart';
import 'custom_text.dart';

Widget headingWidget({String title = '', double size = 24.0, textAlign}) {
  return customText(
      text: title,
      fontSize: size,
      fontColor: colorDarkGrey,
      fontWeight: FontWeight.w700,
      textAlign: textAlign);
}

Widget subHeadingWidget({String title = ''}) {
  return customText(
      text: title,
      fontSize: 16,
      fontColor: colorDarkGrey,
      fontWeight: FontWeight.w700);
}
