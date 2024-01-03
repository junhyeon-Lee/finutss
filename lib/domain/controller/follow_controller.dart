import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/data/graphql_operation/queries/FollowQueries.dart';
import 'package:finutss/data/models/users_model.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:get/get.dart';

class FollowController extends GetxController {
  final authController = Get.put(AuthController());
  var page = 1, limit = 10, totalPages, docs = [], hasNextPage = true;
  var followListIds;

  init() {
    page = 1;
    hasNextPage = true;
    docs = [];
  }

  callFollowPaginate(userId) async {
    print("-callFollowPaginate $hasNextPage");
    //if (!hasNextPage) return;
    var values = {
      "page": page,
      "limit": limit,
      "userId": userId,
    };

    var res =
        await GlobalBloc().queryRepo(FollowQueries.GET_FOLLOWING_USERS, values);
    if (!res["success"]) {
      return LocalDB.snackbar("Error", res["message"]);
    }
    var userPaginate = res["data"]["getFollowing"];
    if (userPaginate != null) {
      userPaginate.forEach((v) {
        docs.add(new User.fromMap(v));
      });
    }
    update();
  }
}
