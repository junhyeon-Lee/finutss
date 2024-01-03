import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/data/graphql_operation/queries/SocialQueries.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:get/get.dart';

class F2FController extends GetxController {
  var page = 1, limit = 10, totalPages, docs = [], hasNextPage = true;

  init() {
    page = 1;
    hasNextPage = true;
    docs = [];
  }

  callFollowerPaginate(userId) async {
    print("-callFollowPaginate $hasNextPage");
    if (!hasNextPage) return;
    var values = {
      "page": page,
      "limit": limit,
      "userId": userId,
      "type": "f2f",
    };

    var res =
        await GlobalBloc().queryRepo(SocialQueries.SOCIAL_PAGINATE, values);
    print("result : f2f SOCIAL_PAGINATE");
    if (!res["success"]) {
      return LocalDB.snackbar("Error", res["message"]);
    }
    var userPaginate = res["data"]["socialPaginate"];
    hasNextPage = userPaginate["hasNextPage"];
    docs.addAll(userPaginate["docs"]);
    update();
  }
}
