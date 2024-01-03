import 'package:flutter/material.dart';
import 'ScrollBottomNavigationBarController.dart';

class ScrollBottomNavigationBar extends StatefulWidget {
  final ScrollController controller;
  final double? elevation;
  final BottomNavigationBarType? type;
  final Color? fixedColor;
  final Gradient? backgroundGradient;
  final double iconSize;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final IconThemeData selectedIconTheme;
  final IconThemeData unselectedIconTheme;
  final double selectedFontSize;
  final double unselectedFontSize;
  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;
  final bool showSelectedLabels;
  final bool? showUnselectedLabels;
  final double? notchMargin;
  final Clip? clipBehavior;
  final NotchedShape? shape;
  final Widget? child;

  ScrollBottomNavigationBar({
    Key? key,
    required this.controller,
    this.elevation,
    this.type,
    this.fixedColor,
    this.backgroundGradient,
    this.iconSize = 24.0,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedIconTheme = const IconThemeData(),
    this.unselectedIconTheme = const IconThemeData(),
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.showSelectedLabels = true,
    this.showUnselectedLabels,
    this.shape, //for bottomAppBar
    this.clipBehavior,
    this.notchMargin,
    this.child,
  })  : assert(controller != null),
        super(key: key);

  @override
  _ScrollBottomNavigationBarState createState() => _ScrollBottomNavigationBarState();
}

class _ScrollBottomNavigationBarState extends State<ScrollBottomNavigationBar> {
  Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: widget.controller.bottomNavigationBar!.tabNotifier,
      builder: _tab,
    );
  }

  Widget _tab(BuildContext context, int index, Widget? child) {
    bottomNavigationBar = BottomAppBar(
      color: widget.fixedColor,
      elevation: widget.elevation,
      shape: widget.shape,
      child: widget.child,
      clipBehavior: widget.clipBehavior!,
      notchMargin: widget.notchMargin!,
    );

    return ValueListenableBuilder<bool>(
      valueListenable: widget.controller.bottomNavigationBar!.pinNotifier,
      builder: _pin,
    );
  }

  Widget _pin(BuildContext context, bool isPinned, Widget? child) {
    if (isPinned) return _align(1.0);

    return ValueListenableBuilder<double>(
      valueListenable: widget.controller.bottomNavigationBar!.heightNotifier,
      builder: (c, h, w) => _height(c, h, w),
    );
  }

  Widget _height(BuildContext context, double height, Widget? child) {
    return _align(height < 0.6 ? 0.7 : height);
  }

  Widget _align(double heightFactor) {
    return Container(
      height: heightFactor * 56,
      child: _elevation(heightFactor),
    );
  }

  Widget _elevation(double heightFactor) {
    return _decoratedContainer(heightFactor);
  }

  Widget _decoratedContainer(double heightFactor) {
    return Container(
      height: widget.controller.bottomNavigationBar!.height,
      child: _opacity(heightFactor),
    );
  }

  Widget? _opacity(double heightFactor) {
    return bottomNavigationBar;
  }
}
