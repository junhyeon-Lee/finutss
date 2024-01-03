import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/presentation/screens/terms_and_agreement_screens/marketing_info_screen.dart';
import 'package:finutss/presentation/screens/terms_and_agreement_screens/privacy_policy_screen.dart';
import 'package:finutss/presentation/screens/terms_and_agreement_screens/terms_agreements_screen.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgreeScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: simpleAppBar(
        text: 'AGREE'.tr,
      ) as PreferredSizeWidget?,
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: GetBuilder<AuthController>(builder: (authController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              size20,
              Center(
                child: customText(
                  text: 'READ_THIS_CONDITION_AND_CHECK_IT'.tr,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.visible,
                  fontColor: colorWhitish,
                  height: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              if (authController.errorText != "")
                Center(
                  child: customText(
                    text: authController.errorText,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.visible,
                    fontColor: Color(0xffFF0000),
                    height: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              size20,
              /* -------------------------- terms and conditions ------------------------- */

              _checkTerms(
                  text: 'ACCEPT_ALL'.tr,
                  optionalText: '',
                  linkText: '',
                  icon: authController.isAcceptAllChecked
                      ? Icons.check_box_outlined
                      : Icons.check_box_outline_blank_outlined,
                  onIconPressed: () {
                    authController.acceptAll();
                  },
                  onLinkPressed: () {},
                  iconColor: authController.isAcceptAllChecked ? colorLightGrey : colorLightSilver),
              _checkTerms(
                  text: '14_YEARS_OF_AGE_OR_OLDER_REQUIRED'.tr,
                  optionalText: 'FINUTSS_SERVICE_IS_NOT_AVAILABLE_UNDER_THE_AGE_OF_14'.tr,
                  linkText: '',
                  icon: authController.isAgeChecked ? Icons.check_box_outlined : Icons.check_box_outline_blank_outlined,
                  onIconPressed: () {
                    authController.ageChecked();
                  },
                  onLinkPressed: () {},
                  iconColor: authController.isAgeChecked ? colorLightGrey : colorLightSilver),
              _checkTerms(
                  text: '',
                  optionalText: '',
                  linkText: 'AGREE_TO_TERMS_OF_SERVICE_REQUIRED'.tr,
                  icon:
                      authController.isTermsChecked ? Icons.check_box_outlined : Icons.check_box_outline_blank_outlined,
                  onIconPressed: () {
                    authController.termsChecked();
                  },
                  onLinkPressed: () {
                    Get.to(() => TermsAgreementsScreen());
                  },
                  iconColor: authController.isTermsChecked ? colorLightGrey : colorLightSilver),
              _checkTerms(
                  text: '',
                  linkText: 'I_AGREE_TO_THE_PRIVACY_POLICY_REQUIRED'.tr,
                  optionalText: '',
                  icon: authController.isPrivacyChecked
                      ? Icons.check_box_outlined
                      : Icons.check_box_outline_blank_outlined,
                  onIconPressed: () {
                    authController.privacyChecked();
                  },
                  onLinkPressed: () {
                    Get.to(() => PrivacyPolicyScreen());
                  },
                  iconColor: authController.isPrivacyChecked ? colorLightGrey : colorLightSilver),
              _checkTerms(
                  text: '',
                  linkText: 'GET_NEWS_OF_EVENTS,_BENEFITS_OPTIONAL'.tr,
                  optionalText: '',
                  icon: authController.isMarketingChecked
                      ? Icons.check_box_outlined
                      : Icons.check_box_outline_blank_outlined,
                  onIconPressed: () {
                    authController.marketingChecked();
                  },
                  onLinkPressed: () {
                    Get.to(() => MarketingInfoScreen());
                  },
                  iconColor: authController.isMarketingChecked ? colorLightGrey : colorLightSilver),
              size40,
              /* --------------------------------- button --------------------------------- */
              Row(
                children: [
                  Expanded(
                    child: customButton(
                        height: 48,
                        textSize: 15,
                        text: "SIGN_UP".tr,
                        fontWeight: FontWeight.w700,
                        color: authController.isSignUp ? Color(0xff3BCCE1) : Color(0xffCDD5E9),
                        onTapFunction: () {
                          authController.onSignUpTerms();
                        }),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _checkTerms(
      {String text = '',
      String linkText = '',
      String optionalText = '',
      icon = Icons.check_box_outline_blank_outlined,
      onLinkPressed,
      onIconPressed,
      iconColor = Colors.blue}) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Row(
        children: [
          IconButton(
              onPressed: onIconPressed,
              icon: Icon(
                icon,
                color: iconColor,
              )),
          size15,
          Expanded(
            child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(style: TextStyle(height: 1.5, color: colorDarkGrey), children: [
                  TextSpan(
                    text: text,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                      text: linkText,
                      style: TextStyle(fontSize: 14),
                      recognizer: TapGestureRecognizer()..onTap = onLinkPressed),
                  TextSpan(
                      text: optionalText,
                      style: TextStyle(
                        fontSize: 12,
                        color: colorWhitish,
                        fontWeight: FontWeight.bold,
                      )),
                ])),
          ),
        ],
      ),
    );
  }
}
