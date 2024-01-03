import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:finutss/data/graphql_operation/queries/UserQueries.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/presentation/widgets/dialogs/settings_dialogs/withdrawal_complete_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WithdrawalController extends GetxController {
  final authController = Get.put(AuthController());
  TextEditingController confirmTextController = TextEditingController();
  TextEditingController otherReasonTextController = TextEditingController();
  var isConfirm = false;
  var isAcceptWithdrawl = false;
  int? radioValue = 0;

  void handleRadioValueChange(int? value) {
    radioValue = value;
    update();
  }

  withdrawal() async {
    if (!isConfirm) return;
    Map<String, dynamic> values = {
      'data': {"type": radioValue, "content": "", "created": authController.user?.userId}
    };
    if (radioValue == 5) {
      if ((otherReasonTextController.text).trim().length == 0) {
        return LocalDB.snackbar("Alert", "이유를 입력해주세요.");
      }
      values["data"]["content"] = otherReasonTextController.text;
    }
    var result = await GlobalBloc().queryMutate(UserQueries.WITHDRAW_USER, values);
    print('result $result');
    Get.dialog(WithdrawalCompleteDialog());
  }

  checkConfirmText() {
    if (confirmTextController.text == 'APPROVE'.tr) {
      isConfirm = true;
    } else {
      isConfirm = false;
    }
    update();
  }
}
