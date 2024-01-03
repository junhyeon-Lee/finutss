import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState>? navigatorKey;

  final String? initialRoute;
  final RouteFactory? onGenerateRoute;

  final Map<String, WidgetBuilder> routes;
  final PageRouteFactory? pageRoute;

  final Widget? home;

  final RouteFactory? onUnknownRoute;

  final List<NavigatorObserver> navigatorObservers;

  const CustomNavigator({
    Key? key,
    this.navigatorKey,
    this.initialRoute,
    this.onGenerateRoute,
    this.routes = const <String, WidgetBuilder>{},
    this.pageRoute,
    this.home,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
  }) : super(key: key);

  @override
  _CustomNavigatorState createState() => _CustomNavigatorState();
}

class _CustomNavigatorState extends State<CustomNavigator>
    implements WidgetsBindingObserver {
  GlobalKey<NavigatorState>? _navigator;
  @override
  didPushRouteInformation(RouteInformation abc) async {
    return true;
  }

  void _setNavigator() =>
      _navigator = widget.navigatorKey ?? GlobalObjectKey<NavigatorState>(this);

  @override
  void initState() {
    _setNavigator();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigator,
      initialRoute: WidgetsBinding.instance.window.defaultRouteName !=
              Navigator.defaultRouteName
          ? WidgetsBinding.instance.window.defaultRouteName
          : widget.initialRoute ??
              WidgetsBinding.instance.window.defaultRouteName,
      onGenerateRoute: _onGenerateRoute,
      onUnknownRoute: _onUnknownRoute,
      observers: widget.navigatorObservers,
    );
  }

  @override
  void didChangeAccessibilityFeatures() => setState(() {});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  void didChangeLocales(List<Locale>? locale) {}

  @override
  void didChangeMetrics() {}

  @override
  void didChangePlatformBrightness() {}

  @override
  void didChangeTextScaleFactor() {}

  @override
  void didHaveMemoryPressure() {}

  @override
  Future<bool> didPopRoute() async {
    assert(mounted);
    final NavigatorState? navigator = _navigator?.currentState;
    if (navigator == null) return false;
    return await navigator.maybePop();
  }

  @override
  Future<bool> didPushRoute(String route) async {
    assert(mounted);
    final NavigatorState? navigator = _navigator?.currentState;
    if (navigator == null) return false;
    navigator.pushNamed(route);
    return true;
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    final String? name = settings.name;
    final WidgetBuilder pageContentBuilder =
        name == Navigator.defaultRouteName && widget.home != null
            ? (BuildContext context) => widget.home!
            : widget.routes[name]!;

    assert(
        widget.pageRoute != null,
        'The default onGenerateRoute handler for CustomNavigator must have a '
        'pageRoute set if the home or routes properties are set.');
    final Route<dynamic> route = widget.pageRoute!<dynamic>(
      settings,
      pageContentBuilder,
    );
    return route;
  }

  Route<dynamic> _onUnknownRoute(RouteSettings settings) {
    assert(() {
      if (widget.onUnknownRoute == null) {
        throw FlutterError(
            'Could not find a generator for route $settings in the $runtimeType.\n'
            'Generators for routes are searched for in the following order:\n'
            ' 1. For the "/" route, the "home" property, if non-null, is used.\n'
            ' 2. Otherwise, the "routes" table is used, if it has an entry for '
            'the route.\n'
            ' 3. Otherwise, onGenerateRoute is called. It should return a '
            'non-null value for any valid route not handled by "home" and "routes".\n'
            ' 4. Finally if all else fails onUnknownRoute is called.\n'
            'Unfortunately, onUnknownRoute was not set.');
      }
      return true;
    }());
    final Route<dynamic> result = widget.onUnknownRoute!(settings)!;
    assert(() {
      if (result == null) {
        throw FlutterError('The onUnknownRoute callback returned null.\n'
            'When the $runtimeType requested the route $settings from its '
            'onUnknownRoute callback, the callback returned null. Such callbacks '
            'must never return null.');
      }
      return true;
    }());
    return result;
  }
}

class PageRoutes {
  static final materialPageRoute =
      <T>(RouteSettings settings, WidgetBuilder builder) =>
          MaterialPageRoute<T>(settings: settings, builder: builder);
  static final cupertinoPageRoute =
      <T>(RouteSettings settings, WidgetBuilder builder) =>
          CupertinoPageRoute<T>(settings: settings, builder: builder);
}
