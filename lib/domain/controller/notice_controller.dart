import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/data/graphql_operation/queries/NoticeQueries.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:get/get.dart';

class NoticeController extends GetxController {
  var page = 1, limit = 10, totalPages, docs = [], hasNextPage = true;

  callPaginateApi({isFirst = false}) async {
    if (isFirst) {
      page = 1;
      docs = [];
      hasNextPage = true;
    }
    print("-callPaginateApi $hasNextPage");
    if (!hasNextPage) return;
    var values = {
      "page": page,
      "limit": limit,
      "findQuery": {"category": "notice"}
    };

    var res =
        await GlobalBloc().queryRepo(NoticeQueries.NOTICE_PAGINATE, values);
    if (!res["success"]) {
      return LocalDB.snackbar("Error", res["message"]);
    }
    var noticePaginate = res["data"]["noticePaginate"];
    hasNextPage = noticePaginate["hasNextPage"];
    docs.addAll(noticePaginate["docs"]);
    update();
  }
}
