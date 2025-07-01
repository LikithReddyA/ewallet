import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:ewallet/core/usecases/usecase.dart';
import 'package:ewallet/features/auth/domain/entities/auth_user.dart';
import 'package:ewallet/features/auth/domain/usecases/get_auth_user.dart';
import 'package:ewallet/features/auth/domain/usecases/get_current_user.dart';
import 'package:ewallet/features/auth/domain/usecases/sign_in_params.dart';
import 'package:ewallet/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/sign_up_params.dart';
import 'package:ewallet/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/user_verification_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUsecase signUpUsecase;
  final SignInUsecase signInUsecase;
  final SignOutUsecase signOutUsecase;
  final GetAuthUser getAuthUser;
  final UserVerificationUsecase userVerificationUsecase;
  final GetCurrentUser getCurrentUser;
  StreamSubscription<AuthUser?>? _userStreamSubscription;

  AuthBloc({
    required this.signUpUsecase,
    required this.signOutUsecase,
    required this.signInUsecase,
    required this.getAuthUser,
    required this.userVerificationUsecase,
    required this.getCurrentUser,
  }) : super(AuthInitial()) {
    on<SignUpRequested>(_onSignUpUsecase);
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<EmailVerificationRequested>(_emailVerificationRequested);
    on<CheckVerificationStatus>(_onCheckVerificationStatus);
    on<AuthUserChanged>(_onAuthUserChanged);
    getAuthUser(NoParams()).then((either) {
      either.fold((_) {}, (authUser) {
        _userStreamSubscription = authUser.listen(
          (user) => add(AuthUserChanged(authUser: user)),
        );
      });
    });
  }

  FutureOr<void> _onSignUpUsecase(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInProgress());
    final result = await signUpUsecase(
      SignUpParams(emailId: event.emailId, password: event.password),
    );

    result.fold((failure) => emit(AuthFailure(message: failure.message!)), (
      user,
    ) {
      if (user.isVerified) {
        emit(AuthSuccess(authUser: user));
      } else {
        emit(AuthUnverified(authUser: user));
        add(EmailVerificationRequested());
      }
    });
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
        emit(AuthUnverified(authUser: user));
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

  FutureOr<void> _onAuthUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) {
    final user = event.authUser;
    if (user != null) {
      if (user.isVerified) {
        emit(AuthSuccess(authUser: user));
      } else {
        emit(AuthUnverified(authUser: user));
      }
    } else {
      emit(AuthUnAuthenticated());
    }
  }

  FutureOr<void> _emailVerificationRequested(
    EmailVerificationRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInProgress());
    final result = await userVerificationUsecase(NoParams());
    result.fold(
      (failure) => emit(AuthFailure(message: failure.message!)),
      (_) => emit(
        AuthUnverified(
          authUser: AuthUser(uid: "", emailId: "", isVerified: false),
        ),
      ),
    );
  }

  FutureOr<void> _onCheckVerificationStatus(
    CheckVerificationStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInProgress());
    final result = await getCurrentUser(NoParams());
    result.fold((failure) => emit(AuthFailure(message: failure.message!)), (
      user,
    ) {
      if (user.isVerified) {
        emit(AuthSuccess(authUser: user));
      } else {
        emit(AuthUnverified(authUser: user));
      }
    });
  }

  @override
  Future<void> close() {
    _userStreamSubscription?.cancel();
    return super.close();
  }
}
