import 'dart:developer';
import 'package:finutss/new%20ui/modules/home/model/notification_model.dart';
import 'package:finutss/new%20ui/modules/home/service/notification_service.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:get/get.dart';

class HomeNotificationController extends GetxController {
  RxList<NotificationArray> notificationList=RxList([]);
  RxBool isLoading = false.obs;

 /* Rx<User> userData = User().obs;
  Rx<Notice> notice = Notice().obs;
  Rx<Notice> eventData = Notice().obs;*/

  Future getNotification() async {
    try {
      notificationList.value=[];
      isLoading.value=true;
      NotificationModel model = await NotificationService.getNotification();
      if (model.statusCode == Constants.successCode200) {
        notificationList.value=model.data?.notificationArray ?? [];
       /* userData.value = model.data?.user ?? User();
        notice.value = model.data?.notice ?? Notice();
        eventData.value = model.data?.event ?? Notice();
        print('userData--->>>>${model.data?.user?.username ?? ""}');*/
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      isLoading.value=false;
    }
  }
}
