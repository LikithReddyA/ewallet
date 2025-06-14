import 'package:flutter/widgets.dart';

class SimpleNavigatorObserver extends NavigatorObserver {
  final void Function({required String from, required String to})? onScreenView;

  SimpleNavigatorObserver({required this.onScreenView});

  String? _getScreenName(Route? route) {
    return route?.settings.name ?? route?.runtimeType.toString();
  }

  void _logTransition(String? from, String? to, String action) {
    final fromScreen = from ?? 'Unknown';
    final toScreen = to ?? 'Unknown';
    final message = '[$action] from: $fromScreen → to: $toScreen';
    debugPrint('[Navigation] $message');

    if (onScreenView != null && to != null && from != to) {
      onScreenView!(from: fromScreen, to: toScreen);
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _logTransition(
      _getScreenName(previousRoute),
      _getScreenName(route),
      'PUSH',
    );
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _logTransition(_getScreenName(route), _getScreenName(previousRoute), 'POP');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _logTransition(
      _getScreenName(oldRoute),
      _getScreenName(newRoute),
      'REPLACE',
    );
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    final removed = _getScreenName(route);
    debugPrint('[Navigation] [REMOVE] Removed route: $removed');
  }
}
