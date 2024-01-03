import 'package:finutss/constants.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/presentation/screens/setting_page/contact_pages/contact_us_page.dart';
import 'package:finutss/presentation/screens/setting_page/event_pages/event_page.dart';
import 'package:finutss/presentation/screens/setting_page/notice_pages/notice_page.dart';
import 'package:finutss/presentation/screens/setting_page/setting_page.dart';
import 'package:finutss/presentation/screens/setting_page/user_guide_list_screen.dart';
import 'package:finutss/presentation/screens/terms_and_agreement_screens/privacy_policy_screen.dart';
import 'package:finutss/presentation/screens/terms_and_agreement_screens/terms_agreements_screen.dart';
import 'package:finutss/presentation/widgets/common_widgets/action_card.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/rounded_decoration.dart';
import 'package:finutss/presentation/widgets/user_notic_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget customer() {
  return Container(
    decoration: roundedDecoration(),
    child: Padding(
      padding: EdgeInsets.all(16.0.r),
      child: Column(
        children: [
          sectionHeading(
            heading: 'CUSTOMER'.tr,
          ),
          size15,
          actionCard(
              heading: 'NOTICE_BOARD'.tr,
              onTapFunction: () {
                Get.dialog(Padding(
                    padding: EdgeInsets.all(16.0.r), child: NoticePage()));
              }),
          size15,
          actionCard(
              heading: 'EVENTS'.tr,
              onTapFunction: () {
                Get.dialog(Padding(
                    padding: EdgeInsets.all(16.0.r), child: EventPage()));
              }),
          size15,
          actionCard(
              heading: 'USER_GUIDE'.tr,
              isSuffixIconShow: false,
              onTapFunction: () {
                Get.to(() => UserGuideListScreen());
              }),
          // size15,
          // actionCard(heading: 'FAQ'.tr, isSuffixIconShow: false),
          size15,
          actionCard(
              heading: 'CONTACT_US'.tr,
              onTapFunction: () async {
                var guest = await LocalDB.getInt("userAsGuest");
                guest == null ? Get.dialog(UserNoticeDialog()) : Get.to(() => ContactUsPage());
              }),
          size15,
          actionCard(
              heading: 'PRIVACY_POLICY'.tr,
              onTapFunction: () {
                Get.to(() => PrivacyPolicyScreen());
              },
              isSuffixIconShow: false),
          size15,
          actionCard(
            heading: 'TERMS_OF_SERVICE'.tr,
            isSuffixIconShow: false,
            onTapFunction: () {
              Get.to(() => TermsAgreementsScreen());
            },
          ),
          size15,
          /* -------------------------------------------------------------------------- */
          /*                            app version and code                            */
          /* -------------------------------------------------------------------------- */
          appVersionAndCode('v.1.2.3.456', 'FC4841KM4121'),
        ],
      ),
    ),
  );
}

Widget appVersionAndCode(version, code) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      customText(text: '$version', fontColor: Color(0xff7F8391), fontSize: 14),
      Row(
        children: [
          customText(text: '$code', fontColor: Color(0xff7F8391), fontSize: 14),
          size15,
          customButton(
              height: 26,
              radius: 6,
              color: colorBlue,
              text: 'COPY'.tr,
              onTapFunction: () {},
              textSize: 10)
        ],
      ),
    ],
  );
}
