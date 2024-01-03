import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/data/graphql_operation/queries/UserQueries.dart';
import 'package:finutss/data/models/users_model.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/black_list_controller.dart';
import 'package:get/get.dart';

import 'follow_controller.dart';

class HotPeopleController extends GetxController {
  final blockListController = Get.put(BlockListController());
  final followController = Get.put(FollowController());
  final authController = Get.put(AuthController());

  var page = 1, limit = 10, totalPages, docs = [], hasNextPage = true;

  onInit() {
    callPaginateApi();
    super.onInit();
  }

  callPaginateApi() {
    print("-callUserInfoApi $hasNextPage");
    if (!hasNextPage) return;
    var values = {"page": page, "limit": limit, "findQuery": {}};
    if (blockListController.blockListIds != null) {
      values['findQuery'] = {
        '_id': {
          '\$nin': [...blockListController.blockListIds, authController.user?.userId]
        },
        'status': 'active'
      };
    }
    values['sort'] = {'follower': 1};

    GlobalBloc().queryRepo(UserQueries.HOT_USERS, values).then((res) {
      print("result : USERS_PAGINATE");
      if (!res["success"]) {
        return LocalDB.snackbar("Error", res["message"]);
      }
      var userPaginate = res["data"]["getHotUsers"];
      if (userPaginate != null) {
        userPaginate.forEach((v) {
          docs.add(new User.fromMap(v));
        });
      }
      //hasNextPage = userPaginate["hasNextPage"];
      // docs.addAll(userPaginate);
      update();
    });
  }
}
