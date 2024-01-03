import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/modules/invite_friends/invite_friend_controller/invite_friend_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class InviteFriendScreen extends StatefulWidget {
  const InviteFriendScreen({Key? key,required this.trackId}) : super(key: key);

  final String trackId;

  @override
  State<InviteFriendScreen> createState() => _InviteFriendScreenState();
}

class _InviteFriendScreenState extends State<InviteFriendScreen> {
  final InviteFriendController controller = Get.find();

  @override
  void initState() {
    super.initState();
   // controller.getData();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 3.w,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [

          CloseButtonCustom(onTap: () { Get.back(); },),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(
                    MediaQuery.of(context).size.width,
                    100.0,
                  ),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:
                EdgeInsets.only(left: 15.w, right: 15.w, top: 30.h),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "INVITE_FRIENDS".tr.toUpperCase(),
                        style: TextStyle(
                          color: AppColor.blueTextColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    Expanded(
                      child: Obx(() =>controller.inviteFriendList.length==0 ? CustomVIew.errorMessageShow('NO_USER_FOUND') : ListView.builder(
                        padding: EdgeInsets.zero,
                        controller: controller.scrollControllerFollowing,
                        itemCount: controller.inviteFriendList.length,
                        itemBuilder: (context, index) {
                          return Obx(() => invitedFriendView(
                            userName: controller
                                .inviteFriendList[index].follower?.username ?? '',
                            userProfile: controller
                                .inviteFriendList[index].follower?.profilePhoto ?? '',
                            userDis: controller
                                .inviteFriendList[index].follower?.description ?? '',
                            isInviteFriend: controller
                                .inviteFriendList[index].isInvite ?? false,
                            onTap: () {
                              if(!(controller.inviteFriendList[index].isInvite ?? false)){
                                controller.sentInvite(userId: controller.inviteFriendList[index].follower?.id ?? '', index: index,trackId: widget.trackId);
                              }
                             /* inviteFriendController
                                  .liveUserList[index].isInviteFriend?.value=!(inviteFriendController.liveUserList[index].isInviteFriend?.value ?? false);
                              inviteFriendController
                                  .liveUserList[index].isInviteFriend?.refresh();*/
                              // Navigation.pushNamed(Routes.reportScreen);
                            },
                          ));
                        },
                      )),
                    ),

                    Obx(() => controller.isLoadingUser.value && !controller.isFirstLoadingFollowing.value
                        ? Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 10.h),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                        : SizedBox())
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }


  Widget invitedFriendView({VoidCallback? onTap,String? userProfile,String? userName,String? userDis,VoidCallback? onTapUserIcon,bool? isInviteFriend}){
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.5.h),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.w),
            color: AppColor.calibrationCardColor,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 11,
          ),
          margin: EdgeInsets.only(bottom: 1.4),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  CustomCircleImageview(
                    width: 55.w,
                    imagePath: userProfile ?? '',
                  ),

                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName ?? '',
                          style: TextStyle(color: AppColor.subTitleColor, fontSize: 12.sp, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Text(
                          userDis ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(fontSize:11,fontWeight: FontWeight.w500,color: AppColor.subTitleColor.withOpacity(0.8)),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 2.w,),
                  InkWell(
                    onTap: onTapUserIcon,
                    child: (isInviteFriend ?? false) ? SvgPicture.asset(
                      IconAssets.inviteGrayIcon ,
                      color: AppColor.iconColorBg,
                    ) : SvgPicture.asset(
                      IconAssets.inviteUserIcon,
                      color: AppColor.purple,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}



