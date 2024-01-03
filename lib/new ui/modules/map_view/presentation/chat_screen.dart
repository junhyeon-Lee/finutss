import 'package:finutss/new%20ui/modules/map_view/controller/chat_controller.dart';
import 'package:finutss/new%20ui/modules/map_view/widget/chat_message_view.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, required this.recordId, required this.token}) : super(key: key);
  String recordId;
  String token;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.scrollDown();
    Navigation.openKeyword();
    controller.recordId = widget.recordId;
  }

  @override
  void dispose() {
    super.dispose();
    // controller.chatLeave();
    //controller.chatMsgList.value=[];
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          color: AppColor.black.withOpacity(0.8),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 25.h,
                    ),
                    chatAppBar(),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Text(
                        'CHATTING_GUIDES'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 11.sp,
                          height: 2,
                          color: AppColor.whiteColor.withOpacity(0.8),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 0.6,
                color: AppColor.whiteColor.withOpacity(0.5),
              ),
              Expanded(
                child: Obx(() => ListView.separated(
                    controller: controller.scrollController,
                    padding: EdgeInsets.only(bottom: 15.w, top: 10.h, left: 15.w, right: 15.w),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, i) {
                      return ChatMessageView(
                        chatModel: controller.chatMsgList.value[i],
                        currentUserId: controller.currentUserId,
                      );
                    },
                    separatorBuilder: (context, i) {
                      return SizedBox(
                        height: 11,
                      );
                    },
                    itemCount: controller.chatMsgList.length)),
              ),
              sendMessageView(),
              SizedBox(
                height: 14.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget chatAppBar() {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: Text(
                'CHATTING'.tr.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 20.sp, letterSpacing: 0.2, color: AppColor.whiteColor.withOpacity(0.8), height: 1.5),
              ),
            ),
          ),
          Positioned(
            right: 14.w,
            top: 0,
            bottom: 0,
            child: InkWell(
              onTap: () {
                Navigation.pop();
              },
              child: SizedBox(
                height: 50.h,
                child: Center(
                  child: Image.asset(
                    IconAssets.close,
                    width: 14.w,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sendMessageView() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
      ),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigation.pop();
            },
            child: Image.asset(
              IconAssets.hideChatIcon,
              width: 36.h,
              height: 36.h,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Container(
              height: 36.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColor.whiteColor,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 11.w,
                  ),
                  Expanded(
                    child: Center(
                      child: TextField(
                        controller: controller.messageController,
                        cursorColor: AppColor.orangeColor,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                        ),
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          hintText: "TYPE_YOUR_MESSAGE".tr,
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColor.blueTextColor.withOpacity(0.5),
                            fontSize: 12.sp,
                          ),
                        ),
                        autofocus: true,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (controller.messageController.text.isNotEmpty) {
                        controller.sendMSGWebsocket(controller.messageController.text);
                        controller.messageController.clear();
                      } else {}
                    },
                    child: SizedBox(
                      height: 36.h,
                      width: 44.w,
                      child: Center(
                        child: SvgPicture.asset(
                          IconAssets.send,
                          height: 18.w,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
