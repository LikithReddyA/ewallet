import 'package:auth_repository/auth_repository.dart';
import 'package:ewallet/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:ewallet/app/blocs/auth_bloc/auth_event_sink.dart';

class AuthUserChangedEventSink implements AuthEventSink {
  final AuthBloc authBloc;
  final AuthRepo authRepo;

  AuthUserChangedEventSink({required this.authBloc, required this.authRepo});

  @override
  Future<void> addAuthUserChangedEvent() async {
    authBloc.add(AuthUserChanged(authRepo.getCurrentUser()));
  }
}
