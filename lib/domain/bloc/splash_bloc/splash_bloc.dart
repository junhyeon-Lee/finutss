import 'dart:async';

import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/domain/bloc/splash_bloc/splash_event.dart';
import 'package:finutss/domain/bloc/splash_bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashStateInitialState()) {
    on<SplashCheckIsFistRunApp>(_mapCheckIsFistRunApp);
  }

  Future<void> _mapCheckIsFistRunApp(
      SplashCheckIsFistRunApp event, Emitter<SplashState> emit) async {
    var token = await LocalDB.getString("token");
    var accessTokenExpiresAt = await LocalDB.getInt("accessTokenExpiresAt");
    var refreshToken = await LocalDB.getString("refreshToken");
    var refreshTokenExpiresAt = await LocalDB.getInt("refreshTokenExpiresAt");

    ///TODO refreshTokenExpiresAt TIME
    if (token != null && accessTokenExpiresAt != null && refreshToken != null) {
      if (accessTokenExpiresAt == null ||
          refreshTokenExpiresAt < DateTime.now().millisecondsSinceEpoch)
        emit(SplashStateIsNotFistRunAppSignInScreen(
            token: token,
            accessTokenExpiresAt: accessTokenExpiresAt,
            refreshToken: refreshToken,
            refreshTokenExpiresAt: refreshTokenExpiresAt));
      emit(SplashStateIsNotFistRunAppMainPage(
          token: token,
          accessTokenExpiresAt: accessTokenExpiresAt,
          refreshToken: refreshToken,
          refreshTokenExpiresAt: refreshTokenExpiresAt));
    } else {
      await LocalDB.getBool('firstRun').then((value) async {
        final bool firstRun = value ?? true;
        await LocalDB.setBool('firstRun', false);
        firstRun == true
            ? emit(SplashStateIsFistRunAppPermissionsInfoScreen())
            : emit(SplashStateIsFistRunAppSignInScreen());
      });
    }
  }
}
