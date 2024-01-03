import 'package:finutss/domain/controller/setting_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../constants.dart';

class TermsAgreementsScreen extends StatelessWidget {
  final _settingController = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    _settingController.jsonTerm ?? _settingController.callApiTerms();
    return Scaffold(
      appBar: simpleAppBar(text: 'TERMS_OF_SERVICE'.tr) as PreferredSizeWidget?,
      body: GetBuilder<SettingController>(builder: (settingController) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              size10,
              Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  child: Html(
                     /* tagsList: Html.tags..remove("br"),*/
                      data: settingController.jsonTerm?["privatePolicy"]?["content"] ?? "")),
            ],
          ),
        );
      }),
    );
  }
}
