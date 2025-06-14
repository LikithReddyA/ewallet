import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;
  late final StreamSubscription _userStreamSubscription;

  AuthBloc({required AuthRepo myAuthRepo})
    : authRepo = myAuthRepo,
      super(const AuthState.unkown()) {
    _userStreamSubscription = authRepo.user.listen((authUser) {
      add(AuthUserChanged(authUser));
    });

    on<AuthUserChanged>((event, emit) {
      if (event.user != null) {
        emit(AuthState.authenticated(event.user!));
      } else {
        emit(AuthState.unauthenticated());
      }
    });
  }

  @override
  Future<void> close() {
    _userStreamSubscription.cancel();
    return super.close();
  }
}
