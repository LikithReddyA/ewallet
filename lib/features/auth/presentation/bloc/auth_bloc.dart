import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:ewallet/core/usecases/usecase.dart';
import 'package:ewallet/features/auth/domain/entities/auth_user.dart';
import 'package:ewallet/features/auth/domain/usecases/sign_in_params.dart';
import 'package:ewallet/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUsecase signInUsecase;
  final SignOutUsecase signOutUsecase;

  AuthBloc({required this.signOutUsecase, required this.signInUsecase})
    : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  FutureOr<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInProgress());
    final result = await signInUsecase(
      SignInParams(emailId: event.emailId, password: event.password),
    );
    result.fold((failure) => emit(AuthFailure(message: failure.message!)), (
      user,
    ) {
      if (user.isVerified) {
        emit(AuthSuccess(authUser: user));
      } else {
        emit(AuthUnverified());
      }
    });
  }

  FutureOr<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInProgress());
    final result = await signOutUsecase(NoParams());
    result.fold(
      (failure) => AuthFailure(message: failure.message!),
      (_) => emit(AuthUnAuthenticated()),
    );
  }
}
