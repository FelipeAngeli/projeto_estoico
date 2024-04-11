import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_estoico/app/bloc/profile/profile_events.dart';
import 'package:projeto_estoico/app/bloc/profile/profile_state.dart';
import 'package:projeto_estoico/app/data/repository/profile_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc({required this.repository}) : super(ProfileInitial()) {
    on<LoadUserProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final user = await repository.fetchUserProfile();
        emit(ProfileLoaded(user));
      } catch (e) {
        emit(ProfileError("Não foi possível carregar o perfil"));
      }
    });

    on<LoadFrases>((event, emit) async {
      emit(FrasesLoading());
      try {
        final frasesCarregadas = await repository.fetchFrases();
        if (frasesCarregadas.isNotEmpty) {
          emit(FrasesLoaded(frasesCarregadas));
        } else {
          emit(NoFrasesSaved());
        }
      } catch (e) {
        emit(ProfileError("Não foi possível carregar as frases"));
      }
    });
  }
}
