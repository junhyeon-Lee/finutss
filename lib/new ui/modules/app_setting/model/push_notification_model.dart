import 'package:get/get.dart';

class PushNotificationModel1{
  String title;
  RxBool isEnable=false.obs;

  PushNotificationModel1(this.title, this.isEnable);
}