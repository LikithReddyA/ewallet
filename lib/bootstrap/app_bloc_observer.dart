import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  void _log(String tag, String message) {
    debugPrint('[$tag] $message');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    _log('BlocEvent', '${bloc.runtimeType} → $event');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    _log('BlocError', '${bloc.runtimeType} → $error');
    debugPrint(stackTrace.toString());
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    _log('BlocChange', '${bloc.runtimeType} → $change');
  }

  // Commented to avoid the sensitive information to get printed in the console
  // @override
  // void onTransition(
  //   Bloc<dynamic, dynamic> bloc,
  //   Transition<dynamic, dynamic> transition,
  // ) {
  //   super.onTransition(bloc, transition);
  //   _log('BlocTransition', '${bloc.runtimeType} → $transition');
  // }
}
