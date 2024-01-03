import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:finutss/data/graphql_operation/queries/ChatQueries.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var listMessage = [];
  final authController = Get.put(AuthController());
  TextEditingController chatTextController = TextEditingController();
  ChatController() {
    GlobalBloc().setChatSubscription(ChatQueries.NEW_CHAT, {'chatRoom': "trackChat"}, callback: (result) {
      print("-receive-");
      print("receive $result");
      listMessage.add(result.data!["newChat"]);
      update();
    });
  }
  enterRoom() async {}

  existRoom() async {
    print("-= Room is exit");
  }

  void sendMsg() {
    var writeId = authController.user?.userId;
    var msg = chatTextController.text;
    if (msg.trim().length == 0) {
      return;
    }

    var data = {
      "data": {
        'description': msg,
        'writer': writeId,
        'chatRoom': 'trackChat',
      }
    };
    GlobalBloc().queryMutate(ChatQueries.WRITE_CHAT, data);
    chatTextController.text = "";
  }
}
