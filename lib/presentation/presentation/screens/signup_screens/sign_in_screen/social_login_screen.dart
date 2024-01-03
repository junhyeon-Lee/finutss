import 'dart:io';
import 'package:finutss/domain/bloc/social_login_bloc/social_login_bloc.dart';
import 'package:finutss/domain/bloc/social_login_bloc/social_login_event.dart';
import 'package:finutss/domain/bloc/social_login_bloc/social_login_state.dart';
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
                                  bloc.add(SocialLoginLoadingCheckAuth(message: msg.message));
                                }),
                            JavascriptChannel(
                                name: 'finish',
                                onMessageReceived: (JavascriptMessage msg) async {
                                })
                          ].toSet(),
                          onWebViewCreated: (WebViewController webViewController) async {
                            _controller = webViewController;
                          },
                          onPageFinished: (finish) {
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
