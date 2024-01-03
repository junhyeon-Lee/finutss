import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finutss/domain/bloc/social_login_bloc/social_login_bloc.dart';
import 'package:finutss/new%20ui/modules/app_setting/service/localization_service_new.dart';
import 'package:finutss/new%20ui/modules/splash/presentation/fintuss_splash_screen.dart';
import 'package:finutss/new%20ui/utils/app_binding.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/no_internet_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Locale? _locale;
var enUS, deDE, esES, frFR, itIT, jaJP, koKR, plPL, ptPT, ruRU, thTH, trTR, zhCN, zhTW;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

RxBool isNoInternetConnected = false.obs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
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

  HttpOverrides.global = MyHttpOverrides();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.black,
    ),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var listener;

  @override
  void initState() {
    super.initState();
    listener = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      ConnectivityResult _connectionStatus = result;
      if (_connectionStatus != ConnectivityResult.mobile || _connectionStatus != ConnectivityResult.wifi) {
        getNetwork();
      }else{
        isNoInternetConnected.value=false;
        isNoInternetConnected.refresh();
      }
      print("MyAPP---isNoInternetConnected::$isNoInternetConnected");
    });
  }

  static getNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      isNoInternetConnected.value=false;
      isNoInternetConnected.refresh();
    } else {
      isNoInternetConnected.value=true;
     //noInternetDialog(Get.context!);
      // getNetwork();
    }
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SocialLoginBloc>(
          create: (context) => SocialLoginBloc(),
        ),
      ],
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColor.whiteColor,
            fontFamily: 'Montserrat',
            brightness: Brightness.dark,
            primaryColor: AppColor.black,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            textTheme: TextTheme(
              displayLarge: TextStyle(
                color: AppColor.black,
              ),
              displayMedium: TextStyle(
                color: AppColor.black,
              ),
              bodyMedium: TextStyle(
                color: AppColor.black,
              ),
              titleMedium: TextStyle(
                color: AppColor.black,
              ),
              displaySmall: TextStyle(
                color: AppColor.black,
              ),
              headlineMedium: TextStyle(
                color: AppColor.black,
              ),
              bodyLarge: TextStyle(
                color: AppColor.black,
              ),
              titleLarge: TextStyle(
                color: AppColor.black,
              ),
            ),
          ),
          home: FintussSplashScreen(),
          initialBinding: AppBidding(),
          // initialRoute: Routes.fintussSplash,
          getPages: Routes.pages,
          locale: _locale,
          // fallbackLocale: LocalizationServiceNew.fallbackLocale,
          translations: LocalizationServiceNew(),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: GestureDetector(
                  onTap: () {
                    hideKeyboard(context);
                  },
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: Stack(
                      children: [
                        child!,
                        Obx(() {
                          return isNoInternetConnected.value ?NoInternetWidget(): SizedBox.shrink() ;
                        })
                      ],
                    ),
                  ),
                ),
              ),
            );
          },

          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('ko', 'KR'),
            // Locale('es', ''), // Spanish, no country code
          ],
        ),
      ),
    );
  }
}

void hideKeyboard(BuildContext context) {
  var currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
