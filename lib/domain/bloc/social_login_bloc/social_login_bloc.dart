import 'dart:convert';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/domain/bloc/social_login_bloc/social_login_event.dart';
import 'package:finutss/domain/bloc/social_login_bloc/social_login_state.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/main_old.dart';
import 'package:finutss/presentation/screens/main_page.dart';
import 'package:finutss/presentation/screens/signup_screens/sign_up_screen/signup_screen_social.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocialLoginBloc extends Bloc<SocialLoginEvent, SocialLoginState> {
  final AuthController authController = Get.put(AuthController());

  SocialLoginBloc() : super(SocialLoginInitialState()) {
    on<SocialLoginLoadingCheckAuth>(_mapCheckAuth);
  }

  void _mapCheckAuth(SocialLoginLoadingCheckAuth event,
      Emitter<SocialLoginState> emit) async {

    print('---event.message-------->${event.message}');
    var data = jsonDecode(event.message);

    print('----------->${data.toString()}');

    YOUR_PERSONAL_ACCESS_TOKEN = data["token"];
    ACCESS_TOKEN_EXPIRES_AT = int.parse(data["accessTokenExpiresAt"]);
    YOUR_PERSONAL_REFRESH_TOKEN = data["refreshToken"];
    REFRESH_TOKEN_EXPIRES_AT = int.parse(data["refreshTokenExpiresAt"]);

    LocalDB.setString('token', YOUR_PERSONAL_ACCESS_TOKEN);
    LocalDB.setInt('accessTokenExpiresAt', ACCESS_TOKEN_EXPIRES_AT);
    LocalDB.setString('refreshToken', YOUR_PERSONAL_REFRESH_TOKEN);
    LocalDB.setInt('refreshTokenExpiresAt', REFRESH_TOKEN_EXPIRES_AT);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setInt('guideIndex', 1);
    authController.callApiMyUserInfo();
    if (data["type"] == "login") {
      Get.offAll(() => MainPage());
    } else if (data["type"] == "signup") {
      Get.off(() => SignUpSocialScreen());
    } else if (data["type"] == "fail") {
      LocalDB.snackbar("alert", "탈퇴 한지 7일이 지나지 않았습니다. ");
      Get.back();
    }
    LocalDB.setString('token', data["token"]);
  }
}