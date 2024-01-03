import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/setting_controller.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:finutss/data/graphql_operation/queries/NoticeQueries.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class QnAController extends GetxController {
  final authController = Get.put(AuthController());
  var page = 1, limit = 10, totalPages, docs = [], hasNextPage = true;

  TextEditingController titleTextController = TextEditingController();
  TextEditingController contentTextController = TextEditingController();

  QnAController() {
    callPaginateApi(isFirst: true);
  }

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
      "findQuery": {"category": "qna", "created": authController.user?.userId}
    };

    var res = await GlobalBloc().queryRepo(NoticeQueries.NOTICE_PAGINATE, values);
    if (!res["success"]) {
      return LocalDB.snackbar("Error", res["message"]);
    }
    var noticePaginate = res["data"]["noticePaginate"];
    hasNextPage = noticePaginate["hasNextPage"];
    docs.addAll(noticePaginate["docs"]);
    update();
  }

  writeQna(type) async {
    if (titleTextController.text.trim().length == 0) {
      return LocalDB.snackbar("Alert", "제목을 입력해주세요.");
    }
    if (contentTextController.text.trim().length == 0) {
      return LocalDB.snackbar("Alert", "내용을 입력해주세요.");
    }

    var isSuccess = await callApiWreteNotice(
        authController.user?.userId as String, type, titleTextController.text.trim(), contentTextController.text.trim());
    if (isSuccess) {
      titleTextController.clear();
      contentTextController.clear();
      callPaginateApi(isFirst: true);
      Get.back();
    }
  }

  callApiWreteNotice(String userId, String type, String title, String content) async {
    var values = {
      'data': {'category': "qna", 'qnaCategory': type, 'name': title, 'content': content, 'created': userId}
    };
    var res = await GlobalBloc().queryMutate(NoticeQueries.ADD_NOTICE, values);
    if (!res["success"]) {
      LocalDB.snackbar("Error", res["message"]);
      return false;
    }
    return true;
  }

  static getQnACategory(type) {
    return SettingController.contactUsList.firstWhere((item) => item[1] == type)[0];
  }

  static getStatus(type) {
    return SettingController.statusList.firstWhere((item) => item[1] == type)[0];
  }
}
