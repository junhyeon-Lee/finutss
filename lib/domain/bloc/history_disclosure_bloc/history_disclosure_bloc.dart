import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/data/graphql_operation/queries/UserQueries.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:finutss/domain/bloc/history_disclosure_bloc/history_disclosure_event.dart';
import 'package:finutss/domain/bloc/history_disclosure_bloc/history_disclosure_state.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HistoryDisclosureBloc
    extends Bloc<HistoryDisclosureEvent, HistoryDisclosureState> {
  final authController = Get.put(AuthController());

  HistoryDisclosureBloc() : super(HistoryDisclosureInitialState()) {
    on<HistoryDisclosureButtonSave>(_mapButtonSave);
  }

  Future<void> _mapButtonSave(HistoryDisclosureButtonSave event,
      Emitter<HistoryDisclosureState> emit) async {
    var result = await GlobalBloc().queryMutate(UserQueries.UPDATE_USER, {
      "id": authController.user?.userId,
      "data": {"infoDisclosure": event.selectedOption}
    });
    if (!result["success"]) {
      LocalDB.snackbar("Alert", result['message']);
      return;
    }
    authController.callApiMyUserInfo();
  }
}
