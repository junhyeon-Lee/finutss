import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/data/graphql_operation/queries/UserQueries.dart';
import 'package:finutss/data/models/users_model.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/black_list_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'follow_controller.dart';

class FindFriendsController extends GetxController {
  final ScrollController scrollController = new ScrollController();
  TextEditingController searchText = TextEditingController();

  final blockListController = Get.put(BlockListController());
  final followController = Get.put(FollowController());
  final authController = Get.put(AuthController());

  var page = 1, limit = 2, totalPages, docs = [], hasNextPage = true;

  init() {
    page = 1;
    hasNextPage = true;
    docs = [];
  }

  callPaginateApi(String userName) {
    if (!hasNextPage) return;
    var values = {"page": page, "limit": limit, "findQuery": {}};
    if (blockListController.blockListIds != null) {
      values['findQuery'] = {
        '_id': {
          '\$nin': [
            ...blockListController.blockListIds,
            ...followController.followListIds,
            authController.user?.userId
          ]
        },
        'status': 'active',
        'nickName': {'\$regex': searchText.text, '\$options': "ig"}
      };
    }

    GlobalBloc().queryRepo(UserQueries.USERS_SEARCH, {"title": userName}).then((res) {
      print("result : USERS_PAGINATE");
      if (!res["success"]) {
        return LocalDB.snackbar("Error", res["message"]);
      }

      var userPaginate = res["data"]["getUsersByUsername"];
      if (userPaginate != null) {
        userPaginate.forEach((v) {
          docs.add(new User.fromMap(v));
        });
      }
      print("docs  =====>${docs.length}");
      //hasNextPage = userPaginate["hasNextPage"];
      // docs.addAll(userPaginate["docs"]);
      update();
    });
  }

  @override
  void onInit() {
    init();
    callPaginateApi(searchText.text.trim());
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (hasNextPage) {
          page = page + 1;
          callPaginateApi(searchText.text.trim());
        }
      }
    });
    super.onInit();
  }
}
