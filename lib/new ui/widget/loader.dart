import 'package:finutss/new%20ui/widget/loader_screen.dart';
import 'package:flutter/material.dart';

BuildContext? _appLoaderContex;

AppLoader(BuildContext context) {
  _appLoaderContex=context;

  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder:
          (BuildContext context, _, __) =>
              LoaderScreen(context),
    ),
  );

}

void RemoveAppLoader() {
  if (_appLoaderContex != null) {
    Navigator.of(_appLoaderContex!).pop();
    _appLoaderContex = null;
  }
}
