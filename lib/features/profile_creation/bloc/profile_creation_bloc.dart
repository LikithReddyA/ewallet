import 'package:equatable/equatable.dart';
import 'package:ewallet/app/blocs/auth_bloc/auth_event_sink.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_repository/wallet_repository.dart';

part 'profile_creation_event.dart';
part 'profile_creation_state.dart';

class ProfileCreationBloc
    extends Bloc<ProfileCreationEvent, ProfileCreationState> {
  final WalletRepo walletRepository;
  final AuthEventSink authEventSink;

  ProfileCreationBloc({
    required WalletRepo myWalletRepository,
    required AuthEventSink myAuthEventSink,
  }) : walletRepository = myWalletRepository,
       authEventSink = myAuthEventSink,
       super(ProfileCreationInitialState()) {
    on<AddProfileCreationEvent>((event, emit) {
      emit(ProfileCreationInprogressState());
      try {
        walletRepository.addUserProfile(event.userProfile, event.banks);
        authEventSink.addAuthUserChangedEvent();
        emit(ProfileCreationSuccessState());
      } catch (e) {
        emit(ProfileCreationFailureState());
      }
    });
  }
}
