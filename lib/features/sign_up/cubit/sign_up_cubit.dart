import 'package:auth_repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.authRepo}) : super(SignUpInitial());
  final AuthRepo authRepo;

  Future<void> signUp(String email, String password) async {
    emit(SignUpInProcess());
    try {
      String uid = await authRepo.signUp(email, password);
      emit(SignUpSuccessful(uid: uid));
    } on SignUpWithEmailPasswordFailure catch (e) {
      emit(SignUpFailure(errorMsg: e.message));
    } catch (_) {
      emit(SignUpFailure(errorMsg: "Something went wrong"));
    }
  }
}
