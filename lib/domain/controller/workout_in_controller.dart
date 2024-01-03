import 'package:finutss/domain/controller/black_list_controller.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:finutss/data/graphql_operation/queries/WorkOutQueries.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:get/get.dart';


class WorkoutInController extends GetxController {
  final blockListController = Get.put(BlockListController());
  var docs = [];

  callPaginateApi() {
    Map<String, dynamic> values = {};
    if (blockListController.blockListIds != null) {
      values['findQuery'] = {
        '_id': {'\$nin': blockListController.blockListIds}
      };
    }

    GlobalBloc().queryRepo(WorkOutQueries.IN_WORKOUT, values).then((res) {
      print("result : IN_WORKOUT");
      if (!res["success"]) {
        return LocalDB.snackbar("Error", res["message"]);
      }
      docs = res["data"]["inWorkOut"];
      update();
    });
  }
}
