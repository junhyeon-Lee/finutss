import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/data/graphql_operation/queries/BlockQueries.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class BlockListController extends GetxController {
  final authController = Get.put(AuthController());

  var blockList;

  var blockListIds;

  Future<void> callApiBlocks() async {
    print('-= callApiBlocks()');
    var result = await GlobalBloc().queryRepo(BlockQueries.BLOCKS, {
      'findQuery': {'created': authController.user?.userId}
    });
    if (!result["success"]) {
      LocalDB.setBool("alert", result["message"]);
      return;
    }
    blockList = result["data"]["blocks"];
    blockListIds = blockList.map(((item) => item['targetId']['id'])).toList();
    update();
  }

  void unlock(id) {
    GlobalBloc().queryMutate(BlockQueries.REMOVE_BLOCK, {"id": id}).then((res) {
      if (!res["success"]) {
        LocalDB.snackbar("Alert", res["message"]);
        return;
      }
      callApiBlocks();
    });
  }
}
