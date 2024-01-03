import 'package:flutter/material.dart';

import 'Snap.dart';

extension ScrollBottomNavigationBarControllerExt on ScrollController {
  static final _controllers = <int, _ScrollBottomNavigationBarController>{};

  _ScrollBottomNavigationBarController? get bottomNavigationBar {
    if (_controllers.containsKey(this.hashCode)) {
      return _controllers[this.hashCode];
    }

    return _controllers[this.hashCode] = _ScrollBottomNavigationBarController(this);
  }
}

class _ScrollBottomNavigationBarController extends ScrollBarsController {
  _ScrollBottomNavigationBarController(ScrollController scrollController)
      : assert(scrollController != null),
        super(scrollController);

  @override
  double height = kBottomNavigationBarHeight;

  /// Notifier of the active page index
  final tabNotifier = ValueNotifier<int>(0);
  // final heightNotifier = ValueNotifier<double>(0);

  /// Register a closure to be called when the tab changes
  void tabListener(Function(int) listener) {
    tabNotifier.addListener(() {
      print(tabNotifier.value);
      listener(tabNotifier.value);
    });
  }

  // void heightListener(Function(double) listener) {
  //   heightNotifier.addListener(() {
  //     listener(heightNotifier.value);
  //   });
  // }

  /// Set a new tab
  void setTab(int index) => tabNotifier.value = index;

  @override
  void dispose() {
    tabNotifier.dispose();
    // heightNotifier.dispose();
    super.dispose();
  }
}
