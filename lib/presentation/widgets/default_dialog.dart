import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DefalutDialog extends StatelessWidget {
  String title;
  String description;
  Widget buttons;
  DefalutDialog({required this.title, required this.description, required this.buttons});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      content: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: headingWidget(title: title)),
            size40,
            Center(
              child: customText(fontSize: 14, textAlign: TextAlign.center, text: description),
            ),
            size20,
            buttons,
          ],
        ),
      ),
    );
  }
}
