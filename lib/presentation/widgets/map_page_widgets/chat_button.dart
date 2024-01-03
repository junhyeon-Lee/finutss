import 'package:finutss/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget chatButton({icon = Icons.chat_bubble, String text = ''}) {
  return InkWell(
    child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Container(
          height: 48,
          width: 130,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              size25,
              Icon(
                icon,
                color: Color(0xff3BCCE1),
              ),
              size10,
              Text(
                text,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )
            ],
          ),
        )),
  );
}
