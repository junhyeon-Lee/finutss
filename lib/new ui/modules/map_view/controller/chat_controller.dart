import 'dart:async';

import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/map_view/model/chat_init_model.dart';
import 'package:finutss/new%20ui/modules/map_view/model/chat_message_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class ChatController extends GetxController {
  late bool connected;
  late String currentUserId;

  TextEditingController messageController = TextEditingController();
  ChatInitModel chatInitModel = ChatInitModel();
  RxList<Rows> chatMsgList = RxList([]);

  final ScrollController scrollController = ScrollController();
  bool keyboardVisible = false;
  String recordId = '';
  Socket? socketIo;

  @override
  void onInit() async {
    super.onInit();
    currentUserId = await SharedPrefs.getUserId();
  }

  void scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  chatInitialize(String token) async {
    if (!recordId.isEmpty) {
      socketIo = io(ApiConstants.baseUrl + '?authorization=${token}', OptionBuilder().setTransports(['websocket']).build());
      Map<String, dynamic> msg1 = {'recordId': recordId};

      socketIo?.connect();
      socketIo?.onConnect((_) {
        print('-----channel connected-----');
        socketIo?.emitWithAck('chat:init', msg1, ack: (data) {
          if (data != null) {
            chatInitModel = ChatInitModel.fromJson(data);
            getChannelMessages();
          } else {
            print("Null");
          }
        });
      });

      socketIo?.on('events', (data) => print('-----channel ==========events--->${data}'));
      socketIo?.on('exception', (data) => print('-----channel ==========exception--->${data}'));

      socketIo?.on('chat:message', (data) {
        Rows rows = Rows.fromJson(data);
        if (((rows.contentType ?? '') != 'info') && (rows.content ?? '') != 'entered the chat') chatMsgList.value.add(Rows.fromJson(data));
        chatMsgList.refresh();
        scrollDown();
      });
      socketIo?.onDisconnect((_) => print('-----channel ======disconnect'));
      socketIo?.on('error', (_) => print('-----channel from error======'));
      socketIo?.onConnectError((err) => print('-----channel ==========onConnectError $err'));
      socketIo?.onError((err) => print('-----channel ==========err===>${err.toString()}'));
    }
  }

  chatLeave() {
    if (socketIo != null) {
      Map<String, dynamic> msg1 = {'recordId': recordId};
      socketIo?.emitWithAck('chat:leave', msg1, ack: (data) {
        if (data != null) {}
      });

      socketIo?.on("chat:leave", (data) => print('-----channel chatLeave--->${data}'));
    }
  }

  getChannelMessages() {
    try {
      if (chatInitModel.data?.chatId != null) {
        //chatMsgList.value=[];
        Map<String, dynamic> msg1 = {'chatId': chatInitModel.data?.chatId};

        socketIo?.emitWithAck('chat:fetch', msg1, ack: (data) {
          if (data != null) {
            ChatMessageModel chatMessageModel = ChatMessageModel.fromJson(data);

            /* List<Rows> tempList=chatMessageModel.data?.chatMessages?.rows ?? [];
            tempList.removeWhere((item) => (item.content ?? '').contains('entered the chat') && item.contentType=='info');
            chatMsgList.value.addAll(tempList);
            chatMsgList.refresh();
            scrollDown();*/
          } else {
            print("Null");
          }
        });

        socketIo?.on("message", (data) => print('-----channel chatFetch---messages--->${data}'));
      }
    } catch (_) {
      print("error on connecting to websocket.");
    }
  }

  Future<void> sendMSGWebsocket(String message) async {
    if (socketIo != null) {
      Map<String, dynamic> msg = {'contentType': 'text', 'content': "$message", 'chatId': '${chatInitModel.data?.chatId}'};

      socketIo?.emitWithAck('chat:send', msg, ack: (data) {
        if (data != null) {
          messageController.text = '';
          if (data['statusCode'] == 200) {
            chatMsgList.value.add(Rows.fromJson(data['data']));
            chatMsgList.refresh();
            scrollDown();
          }
        }
      });
    } else {
      print("Websocket is not connected.");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
