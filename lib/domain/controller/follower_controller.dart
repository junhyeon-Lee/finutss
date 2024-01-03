import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/data/graphql_operation/queries/FollowQueries.dart';
import 'package:finutss/data/models/users_model.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:get/get.dart';

class FollowerController extends GetxController {
  var page = 1;
  int limit = 10;
  var totalPages;
  List<User> docs = [];
  var hasNextPage = true;

  init() {
    page = 1;
    hasNextPage = true;
    docs = [];
  }

  onInit() {
    super.onInit();
  }

  callFollowerPaginate(userId) async {
    print("-callFollowPaginate $hasNextPage");
    //if (!hasNextPage) return;
    var values = {
      "page": page,
      "limit": limit,
      "userId": userId,
      "type": "following",
    };

    var res = await GlobalBloc().queryRepo(FollowQueries.GET_FOLLOWERS_USERS, values);
    if (!res["success"]) {
      return LocalDB.snackbar("Error", res["message"]);
    }
    var userPaginate = res["data"]["getFollowers"];
    if (userPaginate != null) {
      userPaginate.forEach((v) {
        docs.add(new User.fromMap(v));
      });
    }
    update();
  }
}
