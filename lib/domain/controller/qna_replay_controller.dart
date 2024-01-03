import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/qna_controller.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:finutss/data/graphql_operation/queries/CommentQueries.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class QnAReplayController extends GetxController {
  final authController = Get.put(AuthController());
  final qnAController = Get.put(QnAController());
  var page = 1, limit = 10, totalPages, docs = [], hasNextPage = true;
  var selectedQnA;

  TextEditingController commentTextController = TextEditingController();

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
      "findQuery": {"notice": selectedQnA["id"]}
    };

    var res = await GlobalBloc().queryRepo(CommentQueries.COMMENT_PAGINATE, values);
    if (!res["success"]) {
      return LocalDB.snackbar("Error", res["message"]);
    }
    var noticePaginate = res["data"]["commentPaginate"];
    hasNextPage = noticePaginate["hasNextPage"];
    docs.addAll(noticePaginate["docs"]);
    update();
  }

  writeComment() async {
    if (commentTextController.text.trim().length == 0) {
      return LocalDB.snackbar("Alert", "코멘트를 입력해주세요.");
    }

    var isSuccess = await callApiWreteComment(
        selectedQnA['id'], commentTextController.text.trim(), authController.user?.userId as String);
    if (isSuccess) {
      qnAController.callPaginateApi(isFirst: true);
      commentTextController.clear();
    }
  }

  callApiWreteComment(String noticeId, String content, String userId) async {
    var values = {
      'data': {'notice': noticeId, 'content': content, 'created': userId}
    };
    var res = await GlobalBloc().queryMutate(CommentQueries.ADD_COMMENT, values);
    if (!res["success"]) {
      LocalDB.snackbar("Error", res["message"]);
      return false;
    }
    Get.back();
    // callPaginateApi(isFirst: true);
    return true;
  }

  void setSelectQnA(item) {
    selectedQnA = item;
    update();
  }
}
