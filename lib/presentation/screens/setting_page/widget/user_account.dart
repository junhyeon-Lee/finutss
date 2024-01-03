import 'package:finutss/constants.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/black_list_controller.dart';
import 'package:finutss/presentation/screens/setting_page/black_list_page.dart';
import 'package:finutss/presentation/screens/setting_page/my_page/my_page.dart';
import 'package:finutss/presentation/screens/setting_page/setting_page.dart';
import 'package:finutss/presentation/screens/setting_page/subscription_pages/subscription_info_page.dart';
import 'package:finutss/presentation/screens/user_record_screens/profile_dialog.dart';
import 'package:finutss/presentation/widgets/common_widgets/action_card.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/rounded_decoration.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/user_circle_avatar.dart';
import 'package:finutss/presentation/widgets/user_notic_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget userAccount(BuildContext context, AuthController authController) {
  return Container(
    decoration: roundedDecoration(),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0.r),
          child: sectionHeading(
              heading: 'ACCOUNT'.tr,
              buttonFunction: () {
                authController.callLogOutApi({"logout": true});
              },
              buttonText: 'SIGN_OUT'.tr),
        ),
        /* ------------------------------ userInfo Card ----------------------------- */
        InkWell(
          onTap: () {},
          child: LimitedBox(
            maxHeight: 90.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.r),
              child: Container(
                decoration: roundedDecoration(color: colorBackgroundSilver),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 15.h),
                  child: Row(
                    children: [
                      userAvatar(
                          height: 60,
                          width: 60,
                          borderColor: colorBlue,
                          imagePath: authController.user?.image?.url ?? AuthController.userProfileDefaultPath,
                          userInfo: authController.user),
                      size10,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                customText(
                                    fontSize: 12,
                                    fontColor: Color(0xff7F8391),
                                    text: authController.user != null
                                        ? authController.user?.username as String
                                        : "GUEST"),
                              ],
                            ),
                            size10,
                            customText(
                                fontSize: 12,
                                fontColor: Color(0xff303443),
                                text: authController.user != null
                                    ? authController.user?.biography != null
                                        ? authController.user?.biography as String
                                        : ""
                                    : ""),
                          ],
                        ),
                      ),
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () async {
                            var guest = await LocalDB.getInt("userAsGuest");
                            guest == null
                                ? Get.dialog(UserNoticeDialog())
                                : showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return SafeArea(
                                          child: Padding(
                                        padding: EdgeInsets.only(top: 40.0.h),
                                        child: ProfileDialog(),
                                      ));
                                    });
                          },
                          icon: Icon(
                            Icons.more_vert_sharp,
                            size: 24.r,
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        size15,
        /* ------------------------------ action cards ------------------------------ */
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.r),
            child: actionCard(
                heading: 'MY_PAGE'.tr,
                onTapFunction: () async {
                  var guest = await LocalDB.getInt("userAsGuest");
                  guest == null ? Get.dialog(UserNoticeDialog()) : Get.to(MyPage());
                })),
        size15,
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.r),
            child: actionCard(
                heading: 'SUBSCRIPTIONS'.tr,
                activeValue: 'Standard',
                onTapFunction: () async {
                  var guest = await LocalDB.getInt("userAsGuest");
                  guest == null ? Get.dialog(UserNoticeDialog()) : Get.to(() => SubscriptionInfoPge());
                })),
        size15,
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.r),
            child: GetBuilder<BlockListController>(builder: (controller) {
              return actionCard(
                  heading: 'BLACKLIST'.tr,
                  activeValue: '${controller.blockList != null ? controller.blockList.length : 0} People',
                  onTapFunction: () async {
                    var guest = await LocalDB.getInt("userAsGuest");
                    guest == null ? Get.dialog(UserNoticeDialog()) : Get.to(() => BlackListPage());
                  });
            })),
        size15,
      ],
    ),
  );
}
