import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_estoico/app/bloc/profile/profile_events.dart';
import 'package:projeto_estoico/app/bloc/profile/profile_state.dart';
import 'package:projeto_estoico/app/models/user_model.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LoadUserProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        // Substitua este trecho pelo seu método de carregamento
        final user = UserModel(id: "1", name: "John Doe", email: "john.doe@example.com");
        emit(ProfileLoaded(user));
      } catch (e) {
        emit(ProfileError("Não foi possível carregar o perfil"));
      }
    });
  }
}
