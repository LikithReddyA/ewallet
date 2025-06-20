import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_repository/wallet_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;
  final WalletRepo walletRepo;
  late final StreamSubscription _userStreamSubscription;

  AuthBloc({required AuthRepo myAuthRepo, required WalletRepo myWalletRepo})
    : authRepo = myAuthRepo,
      walletRepo = myWalletRepo,
      super(const AuthState.unkown()) {
    _userStreamSubscription = authRepo.user.listen((authUser) {
      add(AuthUserChanged(authUser));
    });

    on<AuthUserChanged>((event, emit) async {
      if (event.user != null) {
        var isProfileCreated = await walletRepo.isProfileCreated(
          event.user!.uid,
        );
        emit(AuthState.authenticated(event.user!, isProfileCreated));
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
