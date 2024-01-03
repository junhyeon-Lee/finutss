import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class SendBirdController extends GetxController with ChannelEventHandler, ConnectionEventHandler {
  final authController = Get.put(AuthController());
  late SendbirdSdk sendbird;

  List<BaseMessage> listMessage = [];

  late User user;

  late OpenChannel channel;

  SendBirdController() {
    sendbird = SendbirdSdk(appId: "1F4A4EAF-F504-4202-ACE2-4B5062EBD5DF");

    //  final params = OpenChannelParams()
    //     ..operatorUserIds = [user.userId]
    //     ..name = 'test'
    //     ..customType = 'CUSTOM_TYPE';

    // final channel = await OpenChannel.createChannel(params);

    // var query = OpenChannelListQuery();
    // var res = await query.loadNext();
    enterRoom();
  }
  enterRoom() async {
    user = await sendbird.connect(authController.user?.userId as String, nickname: "clientTest");
    // final params = OpenChannelParams()
    //   ..operatorUserIds = [user.userId]
    //   ..name = 'test'
    //   ..customType = 'CUSTOM_TYPE';

    // final channel = await OpenChannel.createChannel(params);

    // var query = GroupChannelListQuery()
    //   ..includeEmptyChannel = true
    //   ..limit = 15;

    // var query = OpenChannelListQuery();
    // var res = await query.loadNext();
    // print(res);

    try {
      channel = await OpenChannel.getChannel("sendbird_open_channel_3385_e598d07cabc6ddf9d4f542003d36604c4c7feebe");
      channel.enter();
    } catch (e) {
      print(e);
    }
    // try {
    //   channel = await OpenChannel.getChannel("sendbird_open_channel_3385_e598d07cabc6ddf9d4f542003d36604c4c7feebe");
    //   channel.enter();
    // } catch (e) {
    //   print(e);
    // }

    sendbird.addChannelEventHandler("sendbird_open_channel_3385_e598d07cabc6ddf9d4f542003d36604c4c7feebe", this);

    // channel.sendUserMessageWithText('hello world', onCompleted: (message, error) {
    //   print('${message.message} has been sent!');
    // });
  }

  existRoom() async {
    try {
      sendbird.removeChannelEventHandler("sendbird_open_channel_3385_e598d07cabc6ddf9d4f542003d36604c4c7feebe");
      await channel.exit();
    } catch (e) {
      print(e);
    }
    print("-= Room is exit");
  }

  @override
  void onMessageReceived(BaseChannel _channel, BaseMessage message) {
    print('-=onMessageReceived :: ${message.message}');
    listMessage.add(message);
    print(message.message);
    update();
  }

  @override
  void onMessageUpdated(BaseChannel channel, BaseMessage message) {
    print('-=onMessageUpdated :: ${message.message}');
    super.onMessageUpdated(channel, message);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onReconnectionStarted() {
    print("onReconnectionStarted");
    super.onReconnectionStarted();
  }

  @override
  void onReconnectionSucceeded() {
    print("onReconnectionSucceeded");
    super.onReconnectionSucceeded();
  }

  @override
  void onReconnectionCanceled() {
    print("onReconnectionCanceled");
    super.onReconnectionCanceled();
  }

  @override
  void onReconnectionFailed() {
    print("onReconnectionFailed");
    super.onReconnectionFailed();
  }
}
