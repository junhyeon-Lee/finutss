import 'dart:convert';
import 'dart:io';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/controller/login_controller.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SocialLoginScreenNew extends StatefulWidget {
  SocialLoginScreenNew() : super();

  @override
  _SocialLoginScreen createState() => _SocialLoginScreen();
}

class _SocialLoginScreen extends State<SocialLoginScreenNew> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late WebViewController? _controller;
  late String url;
  bool isLoading = false;
  RxBool isShowWebView=true.obs;
  LoginController controller=Get.find();

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    url = arg['url'];

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          child: Container(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Obx(()=> isShowWebView.value ? WebView(
                    initialUrl: url,
                    userAgent: 'random',
                    javascriptMode: JavascriptMode.unrestricted,
                    javascriptChannels: <JavascriptChannel>[
                      JavascriptChannel(
                        name: 'update',
                        onMessageReceived: (JavascriptMessage msg) async {
                          print('---------javascript update---->${msg.message}');
                          // bloc.add(SocialLoginLoadingCheckAuth(message: msg.message));
                        },
                      ),
                      JavascriptChannel(
                        name: 'finish',
                        onMessageReceived: (JavascriptMessage msg) async {},
                      )
                    ].toSet(),
                    onPageStarted: (String url) {
                      if (!isLoading) {
                        AppLoader(context);
                        isLoading = true;
                      }
                    },
                    onWebViewCreated: (WebViewController webViewController) async {
                      _controller = webViewController;
                      if (!isLoading) {
                        AppLoader(context);
                        isLoading = true;
                      }
                    },
                    onPageFinished: (finish) async {
                      if (isLoading) {
                        Navigation.pop();
                        isLoading = false;
                      }
                      final response =
                      await _controller!.runJavascriptReturningResult(
                        "document.documentElement.innerText",
                      );

                      print('=======socia---->${response.toString()}');
                      var data = jsonDecode(response);
                      if (data != null) {
                        LoginModel model = LoginModel.fromJson(
                          jsonDecode(data),
                        );

                        if (model.statusCode == Constants.successCode201 ||
                            model.statusCode == Constants.successCode200) {
                          isShowWebView.value=false;
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setBool("IsVerification", true);
                          prefs.setBool("IsSocial", true);
                          await SharedPrefs.saveUser(
                              isLogin: true,
                              email: model.data?.email ?? '',
                              userName: model.data?.username ?? '',
                              coverPicture: '',
                              description: model.data?.description,
                              profilePicture: model.data?.profilePhoto ?? '',
                              token: 'Bearer ' + (model.data?.token ?? ''),
                              name: model.data?.firstName ?? '',
                              userId: model.data?.id
                          );
                          Navigation.replaceAll(Routes.dashboardScreen);
                          controller.clearTextField();
                        }
                      }
                    },
                  ) : Container()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
