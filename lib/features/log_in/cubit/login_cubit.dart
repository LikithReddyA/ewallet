import 'package:auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authRepo}) : super(LoginInitial());
  final AuthRepo authRepo;

  Future<void> logIn(String email, String password) async {
    emit(LoginInProgress());
    try {
      String uid = await authRepo.logIn(email, password);
      emit(LoginSuccessful(uid: uid));
    } on LogInWithEmailPasswordFailure catch (e) {
      emit(LoginFailure(message: e.message));
    }
  }

  Future<void> logOut() async {
    emit(LoginInProgress());
    try {
      await authRepo.logOut();
    } catch (e) {
      emit(LoginFailure(message: e.toString()));
    }
  }
}
