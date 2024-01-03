import 'package:finutss/new%20ui/modules/workout/service/workout_record_service.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/log_utils.dart';
import 'package:get/get.dart';
import 'package:finutss/new%20ui/modules/history/model/history_record_model.dart';

class WorkoutResultController extends GetxController {
  RxBool isSelect = false.obs;
  Rx<RecordsArray> WorkoutRecord = RecordsArray().obs;

  @override
  void onInit() {
    super.onInit();

  }




  Future getWorkoutRecord(String recordId) async {
    try {

      Map<String, dynamic> body = {
        "id": recordId,
      };
      print(
          'JavascriptChannel WorkoutResultController getWorkoutRecord-------->update body::$body,');
      HistoryRecordModel model =
      await WorkoutRecordService.getWorkoutRecord(body: body);
      print(
          'JavascriptChannel WorkoutResultController getWorkoutRecord-------->update body::$body response::$model');
      if (model.statusCode == Constants.successCode200) {
        WorkoutRecord.value = model.data?.recordsArray?[0] ?? RecordsArray();
        print("WorkoutRecord.value.id==>>${WorkoutRecord.value.track?.name ?? ""}");
      }
    } catch (e, st) {
    } finally {}
  }

}
