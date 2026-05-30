import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ewallet/core/common/base/base_usecase.dart';
import 'package:ewallet/features/auth/domain/params/login_params.dart';
import 'package:ewallet/features/auth/domain/params/register_params.dart';
import 'package:ewallet/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/login_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/logout_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/refresh_user_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/register_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/send_verification_email_usecase.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_event.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final LogoutUsecase logoutUsecase;
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final RefreshUserUsecase refreshUserUsecase;
  final SendVerificationEmailUsecase sendVerificationEmailUsecase;

  AuthBloc({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.logoutUsecase,
    required this.getCurrentUserUsecase,
    required this.refreshUserUsecase,
    required this.sendVerificationEmailUsecase,
  }) : super(const AuthState()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLogin);
    on<RegisterRequested>(_onRegister);
    on<LogoutRequested>(_onLogout);
    on<RefreshUserRequested>(_onRefreshUserRequested);
    on<VerificationEmailRequested>(_onVerificationEmailRequested);
  }

  Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    final result = await loginUsecase(
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
      (user) {
        if (user.isEmailVerified) {
          emit(
            state.copyWith(
              authStatus: AuthStatus.authenticated,
              authUser: user,
            ),
          );
        } else {
          emit(
            state.copyWith(authStatus: AuthStatus.unverified, authUser: user),
          );
        }
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
    emit(state.copyWith(authStatus: AuthStatus.loading));
    final result = await registerUsecase(
      RegisterParams(email: event.email, password: event.password),
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
      (user) {
        if (user.isEmailVerified) {
          emit(
            state.copyWith(
              authStatus: AuthStatus.authenticated,
              authUser: user,
            ),
          );
        } else {
          emit(
            state.copyWith(authStatus: AuthStatus.unverified, authUser: user),
          );
        }
      },
    );
  }

  FutureOr<void> _onAppStarted(
    AppStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    final result = await getCurrentUserUsecase(NoParams());
    result.fold(
      (failure) {
        emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
      },
      (user) {
        if (user.isEmailVerified) {
          emit(
            state.copyWith(
              authStatus: AuthStatus.authenticated,
              authUser: user,
            ),
          );
        } else {
          emit(
            state.copyWith(authStatus: AuthStatus.unverified, authUser: user),
          );
        }
      },
    );
  }

  Future<void> _onRefreshUserRequested(
    RefreshUserRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    final result = await refreshUserUsecase(NoParams());

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            authStatus: AuthStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (user) {
        if (user.isEmailVerified) {
          emit(
            state.copyWith(
              authStatus: AuthStatus.authenticated,
              authUser: user,
            ),
          );
        } else {
          emit(
            state.copyWith(authStatus: AuthStatus.unverified, authUser: user),
          );
        }
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
