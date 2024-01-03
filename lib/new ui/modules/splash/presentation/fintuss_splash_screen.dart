import 'dart:async';

import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';


bool _initialUriIsHandled = false;


class FintussSplashScreen extends StatefulWidget {
  FintussSplashScreen({Key? key}) : super(key: key);

  @override
  State<FintussSplashScreen> createState() => _FintussSplashScreenState();
}

class _FintussSplashScreenState extends State<FintussSplashScreen> {
  Uri? _initialUri;
  Uri? _latestUri;
  Object? _err;
  StreamSubscription? _sub;
  bool iusOpenCreatePasswordScreen=false;
  String token='';
  String email='';


  @override
  void initState()  {
    super.initState();
    _handleIncomingLinks();
    _handleInitialUri();


    Timer(Duration(seconds: 3),
        () async {
          final bool isLogin = await SharedPrefs.getLogin();
          final bool isVerification = await SharedPrefs.getVerification();
          if(isLogin && isVerification){
            if(iusOpenCreatePasswordScreen){
              Navigation.replaceAll(Routes.createPassword,arg: {
                'token':token,
                'email':email,
              });
            }else {
              Navigation.replaceAll(Routes.dashboardScreen);
            }
          }else {
            final bool onBoarding = await SharedPrefs.getOnBoarding();
            if(iusOpenCreatePasswordScreen){
              Navigation.replaceAll(Routes.createPassword,arg: {
                'token':token,
                'email':email,
              });
            }else {
              if (!onBoarding) {
                Navigation.replaceAll(Routes.appPermissionScreen);
              } else {
                if(isLogin && !isVerification){
                  Navigation.replaceAll(Routes.verificationScreen);
                }else {
                  Navigation.replaceAll(Routes.signIn);
                }
              }
            }
          }
        });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: AppColor.whiteColor),
      child: Material(
        child: Container(
          color: AppColor.whiteColor,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                left: 0,
                top: 64.h,
                child: SvgPicture.asset(
                  ImageAssets.splashLeft,
                  height: 90.h,
                ),
              ),
              Positioned(
                left: 58.w,
                right: 58.w,
                top: 0,
                bottom: 0,
                child: SvgPicture.asset(ImageAssets.fintussSplashLogo),
              ),
              Positioned(
                right: 0,
                bottom: 50.h,
                child: SvgPicture.asset(
                  ImageAssets.splashRight,
                  height: 90.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  void _handleIncomingLinks() {
    if (!kIsWeb) {
      _sub = uriLinkStream.listen((Uri? uri) {
        if (!mounted) return;
        _latestUri = uri;
        _err = null;
      }, onError: (Object err) {
        if (!mounted) return;
        print('got error-------------: $err');
        _latestUri = null;
        if (err is FormatException) {
          _err = err;
        } else {
          _err = null;
        }
      });
    }
  }


  Future<void> _handleInitialUri() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          print('no initial uri--------------');
        } else {
          iusOpenCreatePasswordScreen=true;
          print('got initial uri:------------ $uri');

          String url=uri.toString();
          String start='token';
          final startIndex = url.indexOf(start);
          const end = "";
          final endIndex = url.length;

          token=url.substring(startIndex + start.length, endIndex);
        }
        if (!mounted) return;
      } on PlatformException {
        print('falied to get initial uri---------');
      } on FormatException catch (err) {
        if (!mounted) return;
        print('malformed initial uri-------------');
        setState(() => _err = err);
      }
    }
  }
}
