import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/data/graphql_operation/queries/InviteQueries.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/f2f_controller.dart';
import 'package:get/get.dart';

class InviteFriendsController extends GetxController {
  final f2FController = Get.put(F2FController());
  final authController = Get.put(AuthController());

  var inviteList;

  onInvitedPressed(userId) {
    callApiAddInvite(userId);
    update();
  }

  callApiAddInvite(userId) async {
    var result = await GlobalBloc().queryMutate(InviteQueries.ADD_INVITE, {
      'data': {"to": userId}
    });
    if (!result['success']) {
      LocalDB.snackbar("Alert", result['message']);
      return;
    } else {
      LocalDB.snackbar("Alert", 'Success');
    }
    f2FController.init();
    f2FController.callFollowerPaginate(authController.user?.userId);
    return;
  }

  callApiRemoveInvite(id) async {
    var result =
        await GlobalBloc().queryMutate(InviteQueries.REMOVE_INVITE, {"id": id});
    if (!result["success"]) {
      LocalDB.snackbar("Alert", result["message"]);
      return false;
    }
    return true;
  }

  callApiInviteList() async {
    var result = await GlobalBloc().queryMutate(InviteQueries.INVITES, {
      'findQuery': {"to": authController.user?.userId}
    });
    if (!result['success']) {
      LocalDB.snackbar("Alert", result['message']);
      return;
    } else {
      inviteList = result["data"]["invites"];
    }
    update();
    return;
  }
}
