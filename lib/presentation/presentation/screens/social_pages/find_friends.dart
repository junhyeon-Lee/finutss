import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/find_friends_controller.dart';
import 'package:finutss/domain/controller/social_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/social_page_widgets/friend_request_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FindFriends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FindFriendsController>(
        init: FindFriendsController(),
        builder: (findFriendsController) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: simpleAppBar(text: "FIND_FRIENDS".tr, automaticallyImplyLeading: true) as PreferredSizeWidget?,
            body: GetBuilder<SocialController>(
                init: SocialController(),
                builder: (socialController) {
                  return Column(
                    children: [
                      /* ------------------------------- Search bar ------------------------------- */
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: findFriendsController.searchText,
                          onFieldSubmitted: (value) {
                            findFriendsController.init();
                            findFriendsController.callPaginateApi(findFriendsController.searchText.text.trim());
                          },
                          decoration: InputDecoration(
                            fillColor: Color(0xFFF5F7FA),
                            filled: true,
                            border: UnderlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                            disabledBorder:
                                OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent)),
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent)),
                            errorBorder:
                                OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent)),
                            focusedBorder:
                                OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent)),
                            focusedErrorBorder:
                                OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent)),
                            prefixIcon: Icon(
                              Icons.search,
                              size: 24.r,
                              color: colorDarkGrey,
                            ),
                            hintText: 'SEARCH_FRIEND'.tr,
                            hintStyle: TextStyle(fontSize: 16.sp),
                            suffixIcon: InkWell(
                              onTap: () async {
                                findFriendsController.init();
                                findFriendsController.callPaginateApi(findFriendsController.searchText.text.trim());
                                // socialController.isBeingSearched = !socialController.isBeingSearched;
                                // if (socialController.searchlist.length > 1) {
                                //   socialController.searchlist = [];
                                // } else if (socialController.searchlist.length <= 1) {
                                //   socialController.searchlist.add("apple");
                                // }
                                // socialController.update();
                                // await findFriendsController
                                //     .callPaginateApi(findFriendsController.searchText.text.trim());
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 80,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: colorBlue, borderRadius: BorderRadius.all(Radius.circular(12))),
                                  child: Text(
                                    "SEARCH_FRIEND".tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: colorWhite, fontSize: 16.sp),
                                  ),
                                ),
                              ),
                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      size10,
                      /* ------------------------------ Friends list ------------------------------ */
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: 16, vertical: 8),
                      //   child: Row(
                      //     children: [
                      //       customText(
                      //           text: "Recommended Friends",
                      //           fontColor: Color(0xFF303443),
                      //           fontSize: 20,
                      //           fontWeight: FontWeight.w500),
                      //     ],
                      //   ),
                      // ),
                      findFriendsController.docs.length > 0
                          ? Expanded(
                              child: Container(
                                child: SingleChildScrollView(
                                  controller: findFriendsController.scrollController,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: customText(
                                                text: "SEARCH_INFO".tr,
                                                fontSize: 12,
                                                fontColor: Color(0xFF7F8391),
                                              ),
                                            ),
                                          ],
                                        ),
                                        /* ---------------------------------- tage ---------------------------------- */
                                        // Row(
                                        //   children: [
                                        //     Expanded(
                                        //       child: Wrap(
                                        //         alignment: WrapAlignment.start,
                                        //         children: [
                                        //           for (int i = 0; i < socialController.sugestionList.length; i++)
                                        //             Padding(
                                        //               padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
                                        //               child: Container(
                                        //                 // height: 41.h,
                                        //                 decoration: BoxDecoration(
                                        //                   border: Border.all(),
                                        //                   borderRadius: BorderRadius.circular(12.r),
                                        //                   color: i == socialController.selectedTag
                                        //                       ? Color(0xFFF5F7FA)
                                        //                       : Colors.white,
                                        //                 ),
                                        //                 child: Padding(
                                        //                   padding: EdgeInsets.all(12.r),
                                        //                   child: customText(
                                        //                       fontSize: 12, text: socialController.sugestionList[i]),
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        size10,
                                        if (socialController.isBeingSearched == true)
                                          Padding(
                                            padding: EdgeInsets.symmetric(vertical: 8.h),
                                            child: Row(
                                              children: [
                                                customText(
                                                    text: "RECOMMENDED_FRIENDS".tr,
                                                    fontColor: Color(0xFF303443),
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500),
                                              ],
                                            ),
                                          ),
                                        if (findFriendsController.docs.length > 0)
                                          for (var data in findFriendsController.docs) friendRequestCard(userInfo: data)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  size70,
                                  Container(
                                    height: 220,
                                    width: 280,
                                    child: Image(image: AssetImage("assets/images/friends_not_found.png")),
                                  ),
                                  size40,
                                  customText(
                                      text: "NO_SEARCH_RESULTS_FOUND".tr,
                                      fontColor: Color(0xFF7F8391),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ],
                              ),
                            ),
                    ],
                  );
                }),
          );
        });
  }
}
