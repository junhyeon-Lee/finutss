import 'package:finutss/new%20ui/modules/app_permission/model/app_permission_model.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissionController extends GetxController {
  late List<AppPermissionModel> permissionList = [
    AppPermissionModel(
      IconAssets.deviceIcon,
      AppColor.deviceBG,
      "DEVICE_AND_APP_HISTORY".tr,
      "IMPROVE_SERVICE_AND_CHECK_FOR_ERRORS".tr,
      false,
    ),
    AppPermissionModel(
      IconAssets.bluetooth,
      AppColor.bluetoothBG,
      "BLUETOOTH".tr,
      "SENSOR_CONNECTION_FOR_MOVEMENT_PROGRESS".tr,
      false,
    ),
    AppPermissionModel(
      IconAssets.notificationPink,
      AppColor.notificationBG,
      "NOTIFICATION".tr,
      "PUSH_NOTIFICATION_AND_MESSAGE_RECEPTION_GUIDANCE".tr,
      true,
    ),
    AppPermissionModel(
      IconAssets.gallery,
      AppColor.photoBG,
      "PHOTO_CAMERA".tr,
      "CHANGE_PROFILE_AND_UPLOAD_A_PICTURE_OF_YOUR".tr,
      true,
    ),
    AppPermissionModel(
      IconAssets.mic,
      AppColor.deviceBG,
      "MIC".tr,
      "VOICE_CONVERSATION_BETWEEN_USERS".tr,
      true,
    ),
    // AppPermissionModel(
    //   IconAssets.locationIconSvg,
    //   AppColor.bluetoothBG,
    //   "LOCATION".tr,
    //   "CURRENT_LOCATION-BASED_INTERESTS_AND_USER_GUIDANCE".tr,
    //   true,
    // ),
    AppPermissionModel(
      IconAssets.folderIcon,
      AppColor.notificationBG,
      "STORAGE".tr,
      "CONTENT_STORAGE_FOR_SEAMLESS_SERVICE_PROVIDING".tr,
      true,
    ),
  ];



  Future<void> permissionRequest() async {
  /*  await Permission.storage.request().then((value) async {
      await Permission.microphone.request().then((value) async {
        await Permission.bluetooth.request().then((value) async {
          await Permission.camera.request().then((value) async {
            await Permission.activityRecognition.request().then((value) async {
              await Permission.bluetoothScan.request().then((value) async {
                await Permission.notification.request().then((value) async {
                  await Permission.camera.request().then((value) async {
                    await Permission.activityRecognition.request().then((value) {
                      Navigation.pushNamed(
                        Routes.onBoardingScreen,
                      );
                    });
                  });
                });
              });
            });
          });
        });
      });
    });*/


      await [
        Permission.storage,
        Permission.microphone,
        Permission.bluetooth,
        Permission.bluetoothScan,
        Permission.notification,
        Permission.camera,
        Permission.activityRecognition,
        Permission.bluetoothConnect,
        Permission.bluetoothAdvertise
      ].request();

  }
}
