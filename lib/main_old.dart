import 'dart:async';

import 'package:finutss/domain/bloc/permissions_info_bloc/permissions_info_bloc.dart';
import 'package:finutss/domain/bloc/splash_bloc/splash_bloc.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/service/localization_service_new.dart';
import 'package:finutss/presentation/screens/signup_screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

//import 'package:kakao_flutter_sdk/all.dart';

import 'domain/bloc/history_disclosure_bloc/history_disclosure_bloc.dart';
import 'domain/bloc/main_bloc/main_bloc.dart';
import 'domain/bloc/social_login_bloc/social_login_bloc.dart';
import 'domain/controller/localization_service.dart';

Locale? _locale;
var enUS,
    deDE,
    esES,
    frFR,
    itIT,
    jaJP,
    koKR,
    plPL,
    ptPT,
    ruRU,
    thTH,
    trTR,
    zhCN,
    zhTW;

Future<void> main() async {
  // KakaoContext.clientId = "5d9885ee8088608fada667dfd14c465f";
  WidgetsFlutterBinding.ensureInitialized();
  final locationService = LocalizationServiceNew();
  enUS = await locationService.loadLangNew('en');
  deDE = await locationService.loadLangNew('de');
  esES = await locationService.loadLangNew('es');
  frFR = await locationService.loadLangNew('fr');
  itIT = await locationService.loadLangNew('it');
  jaJP = await locationService.loadLangNew('ja');
  koKR = await locationService.loadLangNew('ko');
  plPL = await locationService.loadLangNew('pl');
  ptPT = await locationService.loadLangNew('pt');
  ruRU = await locationService.loadLangNew('ru');
  thTH = await locationService.loadLangNew('th');
  trTR = await locationService.loadLangNew('tr');
  zhCN = await locationService.loadLangNew('zh-CN');
  zhTW = await locationService.loadLangNew('zh-TW');
  _locale = await locationService.fetchLocale();

  runZonedGuarded<Future<void>>(
    () async {
      runApp(MyApp());
    },
    (dynamic error, StackTrace stackTrace) async {
      var body = {
        "entry.2110522340": '${error}',
        "entry.977300326": '${stackTrace}',
      };

      var client = http.Client();

      var _url =
          'https://docs.google.com/forms/u/0/d/e/1FAIpQLSedqaEr8zVjuwYueHaqy7cOUFxjP5R_aa5LUI3roIGV6NTSOA/formResponse';
      try {
        var resutl = await client.post(Uri.parse(_url), body: body);

        print("Api Restul : ${resutl.statusCode}");
        print("Api Restul : ${resutl.body}");
      } catch (e) {
        print("APi Error : $e");
      }
    },
  );

  runApp(MyApp());
}

String YOUR_PERSONAL_ACCESS_TOKEN =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyLCJyZWZyZXNoVG9rZW4iOiJleUpoYkdjaU9pSklVekkxTmlJc0luUjVjQ0k2SWtwWFZDSjkuZXlKMWMyVnlYMmxrSWpveUxDSnBZWFFpT2pFMk5UTTJOVGs0TmpJc0ltVjRjQ0k2TVRZMU5EQTVNVGcyTW4wLkdZQzZ3V0Q4NkoxSFR2cGtrc3FXekpYWjY0RVVHNkFhNTBPU2k2ZVhwdEkiLCJpYXQiOjE2NTM2NTk4NjIsImV4cCI6MTY1MzY2MTM2Mn0.j5ih-wFUQPpdRrt6tBfxEmO1ab11IATYMpqUnbHTSvM';
int ACCESS_TOKEN_EXPIRES_AT = 0;
String YOUR_PERSONAL_REFRESH_TOKEN = "";
int REFRESH_TOKEN_EXPIRES_AT = 0;

class MyApp extends StatelessWidget {
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider<HistoryDisclosureBloc>(
            create: (context) => HistoryDisclosureBloc(),
          ),
          BlocProvider<PermissionsInfoBloc>(
            create: (context) => PermissionsInfoBloc(),
          ),
          BlocProvider<SocialLoginBloc>(
            create: (context) => SocialLoginBloc(),
          ),
          BlocProvider<SplashBloc>(
            create: (context) => SplashBloc(),
          ),
          BlocProvider<MainBloc>(
            create: (context) => MainBloc(),
          ),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: Colors.white, fontFamily: 'Montserrat'),
          home: landingPage(),
          locale: _locale,
          fallbackLocale: LocalizationService.fallbackLocale,
          translations: LocalizationService(),
          // home: EditGender(),
        ),
      ),
    );
  }
}

Widget landingPage() {
  //return TestResolutionScreen();
  return SplashScreen();

  // return ChatPage();
}
