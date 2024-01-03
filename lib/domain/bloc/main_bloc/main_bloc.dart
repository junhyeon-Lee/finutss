import 'package:finutss/domain/bloc/main_bloc/main_event.dart';
import 'package:finutss/domain/bloc/main_bloc/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {

  MainBloc() : super(MainInitialState()) {
    on<MainEventCheckTapButtonNavigationBarByIndex>(_mapCheckTapButtonNavigationBarByIndex);
  }

  void _mapCheckTapButtonNavigationBarByIndex(MainEventCheckTapButtonNavigationBarByIndex event,
      Emitter<MainState> emit)  {
    final int index = event.index;
    switch (index) {
      case 0:
        emit(MainStateRunHomeScreen());
        break;
      case 1:
        emit(MainStateRunTrackRecordScreen());
        break;
      case 2:
        emit(MainStateRunSocialScreen());
        break;
      case 3:
        emit(MainStateRunSettingPage());
        break;
      case 4:
        emit(MainStateRunDailyTrackScreen());
        break;
    }
  }
}



