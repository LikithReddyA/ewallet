import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ewallet/core/common/base/base_usecase.dart';
import 'package:ewallet/features/auth/domain/params/create_account_params.dart';
import 'package:ewallet/features/auth/domain/params/login_params.dart';
import 'package:ewallet/features/auth/domain/usecases/create_account_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/get_current_session_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/logout_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/refresh_user_session_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/send_verification_email_usecase.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_event.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogoutUsecase logoutUsecase;
  final SendVerificationEmailUsecase sendVerificationEmailUsecase;
  final CreateAccountUsecase createAccountUsecase;
  final LoginUserUsecase loginUserUsecase;
  final GetCurrentSessionUsecase getCurrentSessionUsecase;
  final RefreshUserSessionUsecase refreshUserSessionUsecase;

  AuthBloc({
    required this.logoutUsecase,
    required this.sendVerificationEmailUsecase,
    required this.createAccountUsecase,
    required this.loginUserUsecase,
    required this.getCurrentSessionUsecase,
    required this.refreshUserSessionUsecase,
  }) : super(const AuthState()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLogin);
    on<RegisterRequested>(_onRegister);
    on<LogoutRequested>(_onLogout);
    on<RefreshUserRequested>(_onRefreshUserRequested);
    on<VerificationEmailRequested>(_onVerificationEmailRequested);
  }

  Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.loading, errorMessage: null));
    final result = await loginUserUsecase(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            authStatus: AuthStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (session) {
        final authStatus = session.authUser.isEmailVerified
            ? AuthStatus.authenticated
            : AuthStatus.unverified;

        emit(
          state.copyWith(
            authStatus: authStatus,
            appSession: session,
            errorMessage: null,
          ),
        );
      },
    );
  }

  Future<void> _onLogout(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    final result = await logoutUsecase(NoParams());
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            authStatus: AuthStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (_) {
        emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
      },
    );
  }

  Future<void> _onRegister(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(authStatus: AuthStatus.loading, errorMessage: null));

    final result = await createAccountUsecase(
      CreateAccountParams(
        email: event.email,
        password: event.password,
        displayName: event.displayName,
        photoUrl: event.photoUrl,
      ),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            authStatus: AuthStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (session) {
        final authStatus = session.authUser.isEmailVerified
            ? AuthStatus.authenticated
            : AuthStatus.unverified;

        emit(
          state.copyWith(
            authStatus: authStatus,
            appSession: session,
            errorMessage: null,
          ),
        );
      },
    );
  }

  FutureOr<void> _onAppStarted(
    AppStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(authStatus: AuthStatus.loading, errorMessage: null));
    final result = await getCurrentSessionUsecase(NoParams());
    result.fold(
      (failure) {
        emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
      },
      (session) {
        final authStatus = session.authUser.isEmailVerified
            ? AuthStatus.authenticated
            : AuthStatus.unverified;

        emit(
          state.copyWith(
            authStatus: authStatus,
            appSession: session,
            errorMessage: null,
          ),
        );
      },
    );
  }

  Future<void> _onRefreshUserRequested(
    RefreshUserRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(authStatus: AuthStatus.loading, errorMessage: null));
    final result = await refreshUserSessionUsecase(NoParams());
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            authStatus: AuthStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (session) {
        final authStatus = session.authUser.isEmailVerified
            ? AuthStatus.authenticated
            : AuthStatus.unverified;

        emit(
          state.copyWith(
            authStatus: authStatus,
            appSession: session,
            errorMessage: null,
          ),
        );
      },
    );
  }

  Future<void> _onVerificationEmailRequested(
    VerificationEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    final result = await sendVerificationEmailUsecase(NoParams());
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            authStatus: AuthStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (_) {
        emit(state.copyWith(authStatus: AuthStatus.unverified));
      },
    );
  }
}
