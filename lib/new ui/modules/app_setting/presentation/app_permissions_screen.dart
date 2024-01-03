import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppPermissionsScreen extends StatefulWidget {
  AppPermissionsScreen({Key? key}) : super(key: key);

  @override
  State<AppPermissionsScreen> createState() => _AppPermissionsScreenState();
}

class _AppPermissionsScreenState extends State<AppPermissionsScreen> {
  final List sliderColorList = [
    {
      'title': 'Location',
      'color': Color(0xff4CAFF6).withOpacity(0.2),
      'icon': IconAssets.location1,
      'value': false,
    },
    {
      'title': 'Storage',
      'color': Color(0xffFF559C).withOpacity(0.2),
      'icon': IconAssets.folder,
      'value': false,
    },
    {
      'title': 'Phone',
      'color': Color(0xff8D4FD0).withOpacity(0.2),
      'icon': IconAssets.phone,
      'value': false,
    },
    {
      'title': 'Contact',
      'color': Color(0xff2A9D8F).withOpacity(0.2),
      'icon': IconAssets.contact,
      'value': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomSettingRow(
              title: "APP_PERMISSIONS".tr,
              horizontalPadding: 20.w,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: sliderColorList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(
                                7,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColor.cardGradiant1.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 15,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 5.5.h,
                              horizontal: 10.w,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 8.w,
                                ),
                                CircleAvatar(
                                  child: Image.asset(
                                    sliderColorList[index]["icon"],
                                    height: 12.h,
                                  ),
                                  backgroundColor: sliderColorList[index]
                                      ["color"],
                                  radius: 16.w,
                                ),
                                SizedBox(
                                  width: 17.w,
                                ),
                                Text(
                                  sliderColorList[index]["title"],
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    letterSpacing: 0.2,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.blueTextColor,
                                  ),
                                ),
                                Spacer(),
                                Transform.scale(
                                  scale: 0.9,
                                  child: Switch(
                                    onChanged: (bool value) {
                                      setState(() {
                                        sliderColorList[index]['value'] =
                                            !sliderColorList[index]['value'];
                                      });
                                    },
                                    value: sliderColorList[index]['value'],
                                    activeColor: AppColor.orangeColor,
                                    activeTrackColor:
                                        AppColor.orangeColor.withOpacity(0.2),
                                    inactiveThumbColor: AppColor.inActiveSwitch,
                                    inactiveTrackColor: AppColor.inActiveSwitch,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 9.h,
                        );
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    RichText(
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.end,
                      textDirection: TextDirection.rtl,
                      softWrap: true,
                      maxLines: 5,
                      textScaleFactor: 1,
                      text: TextSpan(
                        text:
                            'For smooth use of the services, please allow us to receive',
                        style: TextStyle(
                          color: AppColor.blueTextColor.withOpacity(0.7),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w300,
                          height: 1.5.h,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' App Notifications',
                            style: TextStyle(
                              color: AppColor.blueTextColor.withOpacity(0.6),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                              height: 1.5.h,
                            ),
                          ),
                          TextSpan(
                            text: ' from',
                            style: TextStyle(
                              color: AppColor.blueTextColor.withOpacity(0.7),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w300,
                              height: 1.5.h,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' [Settings > Applications > Peanuts > Notifications]',
                            style: TextStyle(
                              color: AppColor.blueTextColor.withOpacity(0.6),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                              height: 1.5.h,
                            ),
                          ),
                          TextSpan(
                            text: ' on your mobile device',
                            style: TextStyle(
                              color: AppColor.blueTextColor.withOpacity(0.7),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w300,
                              height: 1.5.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 200.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
