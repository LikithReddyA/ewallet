import 'dart:async';

import 'package:flutter/foundation.dart';

class GoRouteSteamToListenable extends ChangeNotifier {
  late final StreamSubscription _streamSubscription;

  GoRouteSteamToListenable(Stream stream) {
    _streamSubscription = stream.asBroadcastStream().listen(
      (_) => notifyListeners(),
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
