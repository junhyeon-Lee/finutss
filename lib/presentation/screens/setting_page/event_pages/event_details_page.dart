import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDetailsPage extends StatelessWidget {
  var event;
  EventDetailsPage(event) {
    this.event = event;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundSilver,
      appBar: simpleAppBar(text: '${event != null ? event['name'] : ""}', actions: [
        Padding(
            padding: EdgeInsets.all(0.0),
            child: IconButton(
                padding: EdgeInsets.all(16.r),
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                  size: 24.r,
                  color: colorBlue,
                )))
      ]) as PreferredSizeWidget?,
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(16.r),
                    margin: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.white,
                    ),
                    child: Html(/*tagsList: Html.tags..remove("br"),*/ data: event != null ? event['content'] : "")
                ),
                size10,
                Row(
                  children: [
                    Expanded(
                        child: customButton(
                            radius: 15,
                            height: 48,
                            onTapFunction: () {},
                            fontWeight: FontWeight.bold,
                            textSize: 16,
                            text: 'JOIN THE EVENT')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
