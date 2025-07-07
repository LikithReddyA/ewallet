import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ewallet/features/profile/domain/usecases/create_user_profile_params.dart';
import 'package:ewallet/features/profile/domain/usecases/create_user_profile_usecase.dart';
import 'package:ewallet/features/shared/domain/entities/category.dart';
import 'package:ewallet/features/shared/domain/entities/source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final AuthBloc authBloc;
  final CreateUserProfileUsecase createUserProfileUsecase;

  UserProfileBloc({
    required this.authBloc,
    required this.createUserProfileUsecase,
  }) : super(UserProfileInitial()) {
    on<UserProfileCreation>(_onUserProfileCreation);
  }

  FutureOr<void> _onUserProfileCreation(
    UserProfileCreation event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(UserProfileInprogress());
    final state = authBloc.state;
    if (state is AuthSuccess) {
      final userId = state.authUser.uid;
      final result = await createUserProfileUsecase(
        CreateUserProfileParams(
          userId: userId,
          username: event.username,
          dob: event.dob,
          sources: event.sources,
          incomeCategories: event.incomeCategories,
          expenseCategories: event.expenseCategories,
        ),
      );

      result.fold(
        (failure) => emit(UserProfileFailure(message: failure.message!)),
        (_) => emit(CreateUserProfileSuccess()),
      );
    } else {
      emit(UserProfileFailure(message: "Login with a valid user!!!"));
    }
  }
}
