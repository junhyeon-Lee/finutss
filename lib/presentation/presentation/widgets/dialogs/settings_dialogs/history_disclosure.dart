import 'package:finutss/constants.dart';
import 'package:finutss/domain/bloc/history_disclosure_bloc/history_disclosure_bloc.dart';
import 'package:finutss/domain/bloc/history_disclosure_bloc/history_disclosure_event.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/rounded_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HistoryDisclosure extends StatefulWidget {
  @override
  _HistoryDisclosureState createState() => _HistoryDisclosureState();
}

class _HistoryDisclosureState extends State<HistoryDisclosure> {
  late HistoryDisclosureBloc bloc;
  String selectedOption = 'friends';
  List optionList = [
    ['ALL'.tr, 'All'],
    ['FRIENDS'.tr, 'Friends'],
    ['PRIVATE'.tr, 'Private']
  ];

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<HistoryDisclosureBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
            height: 390.h,
            decoration: roundedDecoration(color: Colors.white, radius: 12),
            child: Padding(
              padding: EdgeInsets.fromLTRB(24.w, 36.h, 24.w, 30.h),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customText(
                        text: 'HISTORY_DISCLOSURE'.tr,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ],
                ),
                size15,
                for (var data in optionList)
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedOption = data[1];
                      });
                    },
                    child: Container(
                      height: 64.h,
                      decoration: BoxDecoration(
                          color: data[1] == selectedOption ? colorBlue : colorBackgroundSilver,
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            data[1] == selectedOption[1]
                                ? Container(
                                    height: 20.h,
                                    width: 20.h,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage('assets/icons/un_check.png'))),
                                  )
                                : size20,
                            Text(
                              " ${data[0]}",
                              style: TextStyle(
                                  color: data[1] == selectedOption ? Colors.white : Color(0xff7F8391),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            size20,
                          ],
                        ),
                      ),
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(15.r)),
                        child: customButton(
                          color: Colors.white,
                          textColor: Colors.black,
                          radius: 15,
                          fontWeight: FontWeight.bold,
                          text: 'CANCEL'.tr,
                          textSize: 16,
                          onTapFunction: () {
                            Get.back();
                          },
                          height: 48,
                        ),
                      ),
                    ),
                    size5,
                    Expanded(
                      child: customButton(
                        radius: 15,
                        fontWeight: FontWeight.bold,
                        text: 'SAVE'.tr,
                        textSize: 16,
                        onTapFunction: () {
                          bloc.add(HistoryDisclosureButtonSave(selectedOption: selectedOption));
                          Get.back();
                        },
                        height: 48,
                      ),
                    )
                  ],
                )
              ]),
            )),
      ),
    );
  }
}
