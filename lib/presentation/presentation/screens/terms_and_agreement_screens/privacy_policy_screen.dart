import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/setting_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  final _settingController = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    _settingController.jsonTerm ?? _settingController.callApiTerms();
    return Scaffold(
      appBar: simpleAppBar(text: 'PRIVACY_POLICY'.tr) as PreferredSizeWidget?,
      body: GetBuilder<SettingController>(builder: (settingController) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: EdgeInsets.only(right: 13.w),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       customText(
              //         text: 'June 10, 2021',
              //         fontColor: Color(0xff7F8391),
              //       ),
              //       IconButton(
              //         onPressed: () {},
              //         padding: EdgeInsets.zero,
              //         icon: Icon(
              //           Icons.keyboard_arrow_down_sharp,
              //           size: 24.r,
              //           color: Color(0xff7F8391),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              size10,
              Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  child: Html(
                   /*   tagsList: Html.tags..remove("br"),*/
                      data: settingController.jsonTerm?["privatePolicy"]?["content"] ?? "")),
            ],
          ),
        );
      }),
    );
  }
}
