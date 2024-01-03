import 'dart:convert';
import 'dart:io';
import 'package:finutss/domain/bloc/social_login_bloc/social_login_bloc.dart';
import 'package:finutss/domain/bloc/social_login_bloc/social_login_state.dart';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/presentation/widgets/common_widgets/notification_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SocialLoginScreen extends StatefulWidget {
  final String url;
  SocialLoginScreen({required this.url}) : super();

  @override
  _SocialLoginScreen createState() => _SocialLoginScreen();
}

class _SocialLoginScreen extends State<SocialLoginScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late WebViewController? _controller;
  late SocialLoginBloc bloc;


  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<SocialLoginBloc>(context);
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SocialLoginBloc, SocialLoginState>(
        child: Scaffold(
            key: scaffoldKey,
            endDrawer: ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),
                  topLeft: Radius.circular(15)),
              child: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.transparent,
                ),
                child: SafeArea(
                  child: Drawer(
                    elevation: 0,
                    child: NotificationDrawer(),
                  ),
                ),
              ),
            ),
            body: SafeArea(
                child: Container(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: WebView(
                          initialUrl: widget.url,
                          userAgent: 'random',
                          javascriptMode: JavascriptMode.unrestricted,
                          javascriptChannels: <JavascriptChannel>[
                            JavascriptChannel(
                                name: 'update',
                                onMessageReceived: (JavascriptMessage msg) async {
                                 // bloc.add(SocialLoginLoadingCheckAuth(message: msg.message));
                                }),
                            JavascriptChannel(
                                name: 'finish',
                                onMessageReceived: (JavascriptMessage msg) async {
                                })
                          ].toSet(),
                          onWebViewCreated: (WebViewController webViewController) async {
                            _controller = webViewController;
                          },
                          onPageFinished: (finish) async {
                            print('------page finish------${finish.toString()}');
                            final response = await _controller!.runJavascriptReturningResult("document.documentElement.innerText");

                            var data = jsonDecode(response);
                            if(data!=null){
                              if(data['statusCode']==Constants.successCode201){
                                LoginModel model=LoginModel.fromJson(data);
                                await SharedPrefs.saveUser(
                                  isLogin: true,
                                  email: model.data!.email,
                                  userName: model.data!.username,
                                  coverPicture: '',
                                  description: model.data?.description,
                                  profilePicture: model.data!.profilePhoto,
                                  token: 'Bearer '+model.data!.token!,
                                  name: model.data!.firstName,
                                    userId: model.data?.id
                                );
                                Navigation.replaceAll(Routes.dashboardScreen);
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )
            )
        ),
        listener: (context, state) {},
    );
  }
}
