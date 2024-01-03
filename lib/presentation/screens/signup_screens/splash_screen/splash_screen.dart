import 'package:finutss/domain/bloc/splash_bloc/splash_bloc.dart';
import 'package:finutss/domain/bloc/splash_bloc/splash_event.dart';
import 'package:finutss/domain/bloc/splash_bloc/splash_state.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/new%20ui/modules/home/presentation/home_screen.dart';
import 'package:finutss/presentation/screens/main_page.dart';
import 'package:finutss/presentation/screens/signup_screens/permissions_info_screen/permissions_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finutss/main_old.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen() : super();

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  final AuthController authController = Get.put(AuthController());
  late SplashBloc bloc;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((result) {
      _prefs = result;
    });
    bloc = BlocProvider.of<SplashBloc>(context);
    bloc.add(SplashCheckIsFistRunApp(authController: authController));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) async {
        if (state is SplashStateIsFistRunAppSignInScreen) {
          Get.off(() => HomeScreen());
        }

        if (state is SplashStateIsFistRunAppPermissionsInfoScreen) {
          Get.off(() => PermissionsInfoScreen());
        }

        if (state is SplashStateIsNotFistRunAppSignInScreen) {
          _prefs.setInt('guideIndex', 1);
          authController.callApiMyUserInfo();
          YOUR_PERSONAL_ACCESS_TOKEN = state.token;
          ACCESS_TOKEN_EXPIRES_AT = state.accessTokenExpiresAt;
          YOUR_PERSONAL_REFRESH_TOKEN = state.refreshToken;
          REFRESH_TOKEN_EXPIRES_AT = state.refreshTokenExpiresAt;
          Get.off(() => HomeScreen());
        }

        if (state is SplashStateIsNotFistRunAppMainPage) {
          _prefs.setInt('guideIndex', 1);
          authController.callApiMyUserInfo();
          YOUR_PERSONAL_ACCESS_TOKEN = state.token;
          ACCESS_TOKEN_EXPIRES_AT = state.accessTokenExpiresAt;
          YOUR_PERSONAL_REFRESH_TOKEN = state.refreshToken;
          REFRESH_TOKEN_EXPIRES_AT = state.refreshTokenExpiresAt;
          Get.off(() => MainPage());
        }
      },
      child: Scaffold(),
    );
  }
}
