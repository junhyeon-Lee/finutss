import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationDetailsPage extends StatelessWidget {
  var notice;
  NotificationDetailsPage(notice) {
    this.notice = notice;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundSilver,
      appBar: simpleAppBar(text: '${notice != null ? notice['name'] : ""}', actions: [
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
          child: Container(
              padding: EdgeInsets.all(16.r),
              margin: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Html(/*tagsList: Html.tags..remove("br"),*/ data: notice != null ? notice['content'] : "")),
        ),
      ),
    );
  }
}
