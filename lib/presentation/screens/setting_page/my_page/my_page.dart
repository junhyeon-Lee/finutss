import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/presentation/screens/setting_page/my_page/change_new_password_screen.dart';
import 'package:finutss/presentation/screens/setting_page/my_page/initialize_app_data.dart';
import 'package:finutss/presentation/screens/setting_page/my_page/withdrawal_page.dart';
import 'package:finutss/presentation/widgets/common_widgets/action_card.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/rounded_decoration.dart';
import 'package:finutss/presentation/widgets/dialogs/settings_dialogs/history_disclosure.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPage extends StatelessWidget {
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundSilver,
      appBar: simpleAppBar(text: 'MY_PAGE'.tr) as PreferredSizeWidget?,
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(16.r),
            padding: EdgeInsets.all(16.r),
            decoration: roundedDecoration(),
            child: Column(
              children: [
                /* ------------------------------ action cards ------------------------------ */
                ///TODO authController.user?["social"] ?
                //if ((authController.user?["social"] ?? null) == null)
                  actionCard(
                      heading: 'CHANGE_PASSWORD'.tr,
                      onTapFunction: () {
                        Get.to(() => ChangeNewPasswordScreen());
                      }),
                size15,
                GetBuilder<AuthController>(builder: (controller) {
                  ///TODO controller.user["infoDisclosure"]
                  //var infoDisclosure = controller.user != null ? controller.user["infoDisclosure"] : "";
                  return actionCard(
                      heading: 'HISTORY_DISCLOSURE'.tr,
                      ///TODO
                      //activeValue: infoDisclosure,
                      onTapFunction: () {
                        Get.dialog(Padding(padding: EdgeInsets.all(16.r), child: HistoryDisclosure()));
                      });
                }),
                size15,
                actionCard(
                    heading: 'INITIALIZE_APP_DATA'.tr,
                    onTapFunction: () {
                      Get.to(() => InitializeAppData());
                    }),
                size15,
                actionCard(
                    heading: 'WITHDRAWAL'.tr,
                    onTapFunction: () {
                      Get.to(() => WithdrawalPage());
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
