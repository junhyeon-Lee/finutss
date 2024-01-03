import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/chat_controller.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/presentation/widgets/chat_page_widgets/message_card.dart';
import 'package:finutss/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  final chatController = Get.put(ChatController());
  final authController = Get.put(AuthController());
  var userId;

  @override
  Widget build(BuildContext context) {
    userId = authController.user?.userId;
    return Scaffold(
      backgroundColor: colorLightGrey.withOpacity(0.9),
      body: Stack(
        children: [
          /* -------------------------------------------------------------------------- */
          /*                                 Chat page                                */
          /* -------------------------------------------------------------------------- */
          Positioned.fill(
              child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                /* --------------------------------- heading -------------------------------- */
                Text('CHATTING'.tr,
                    style: TextStyle(fontSize: 24.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                size25,
                Text('CHATTING_GUIDES'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.sp, height: 1.5, color: colorBackgroundSilver.withOpacity(0.9))),
                size20,
                Expanded(
                  child: GetBuilder<ChatController>(builder: (controller) {
                    return ListView.builder(
                        reverse: true,
                        itemCount: controller.listMessage.length,
                        itemBuilder: (BuildContext context, index) {
                          /* -------------------------------------------------------------------------- */
                          /*                                 chata card                                 */
                          /* -------------------------------------------------------------------------- */
                          var reversedList = new List.from(controller.listMessage.reversed);
                          var isSendByMe = reversedList[index]["writer"]["id"] == userId;

                          return messageCard(
                              isSendByMe: isSendByMe,
                              senderName: reversedList[index]["writer"]['nickName'],
                              message: reversedList[index]['description'],
                              time: LocalDB.convertDateFormat(reversedList[index]['createdAt'], "HH:mm"),
                              userImagePath: reversedList[index]?['writer']?['image']?['url'] ??
                                  AuthController.userProfileDefaultPath);
                        });
                  }),
                ),

                /* -------------------------------------------------------------------------- */
                /*                           message send text field                          */
                /* -------------------------------------------------------------------------- */
                TextField(
                  maxLines: null,
                  maxLength: 120,
                  style: TextStyle(fontSize: 16.sp),
                  controller: chatController.chatTextController,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 16.sp),
                      hintText: 'TYPE_YOUR_MESSAGE'.tr,
                      border:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(32.r), borderSide: BorderSide.none),
                      filled: true,
                      contentPadding: EdgeInsets.all(16.r),
                      fillColor: colorBackgroundSilver,
                      suffixIcon: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: Icon(
                              Icons.send,
                              size: 24.r,
                              color: colorBlue,
                            ),
                            onPressed: () {
                              print("-= send msg");
                              chatController.sendMsg();
                            },
                          ))),
                ),
              ],
            ),
          )),
          /* -------------------------------------------------------------------------- */
          /*                                cross button                                */
          /* -------------------------------------------------------------------------- */
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 5.h),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.cancel,
                  color: colorBackgroundSilver,
                  size: 40.r,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

/* ------------------------------- dummy data ------------------------------- */
  final List messageData = [
    {'time': '15:03', 'message': "How have you been?", 'isSendByMe': true},
    {
      'senderName': 'Farhan',
      'time': '14:04',
      'senderPic': 'assets/images/user6.png',
      'message': "Moomin, long time no see. How have you been?",
      'isSendByMe': false
    },
    {
      'senderName': 'Rreazul',
      'time': '14:03',
      'senderPic': 'assets/images/user3.png',
      'message': "Hello~ It's been a while.",
      'isSendByMe': false
    },
  ];
}
