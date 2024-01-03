import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:flutter/material.dart';

class NotificationDescription extends StatelessWidget {
  final String title;
  final String text;

  NotificationDescription({Key? key, required this.title, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(
        text: title,
        actions: [
          Icon(
            Icons.share,
            color: Colors.black,
          ),
          size15,
        ],
      ) as PreferredSizeWidget,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
        ),
        child: Column(
          children: [
            size40,
            Text(
              text,
            ),
          ],
        ),
      ),
    );
  }
}
