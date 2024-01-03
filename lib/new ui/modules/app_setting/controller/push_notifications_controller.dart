import 'package:finutss/new%20ui/modules/app_setting/model/push_notification_model.dart';
import 'package:get/get.dart';

class PushNotificationsController extends GetxController {

  RxList<PushNotificationModel1> NotificationModel1=RxList([
    PushNotificationModel1("ALL",false.obs),
    PushNotificationModel1("APP_SYSTEMS",false.obs),
    PushNotificationModel1("WORKOUT_ROUTINE",false.obs),
    PushNotificationModel1("INVITE",false.obs),
    PushNotificationModel1("DO_NOT_DISTURB",true.obs),
  ]);

}
