import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


Widget promoCard({required String imageUrl, String? url}) {
  return InkWell(
    onTap: () async {
      print("ads link:  $url");
      if (url != null && !await launch(url)) throw 'Could not launch $imageUrl';
    },
    child: Padding(
      padding: EdgeInsets.all(4.0.r),
      child: Container(
        height: 160.h,
        width: 302.w,
        /* -------------------------------------------------------------------------- */
        /*                              background image                              */
        /* -------------------------------------------------------------------------- */
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
        ),
        child: CachedNetworkImage(
            imageUrl: imageUrl, fit: BoxFit.fill
        ),
      ),
    ),
  );
}


