import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_estoico/app/modules/profile/blocs/profile/profile_events.dart';
import 'package:projeto_estoico/app/modules/profile/blocs/profile/profile_state.dart';
import 'package:projeto_estoico/app/core/data/repository/profile_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    // on<LoadFrases>((event, emit) async {
    //   emit(FrasesLoading());
    //   try {
    //     final frasesCarregadas = await repository.fetchFrases();
    //     if (frasesCarregadas.isNotEmpty) {
    //       emit(FrasesLoaded(frasesCarregadas));
    //     } else {
    //       emit(NoFrasesSaved());
    //     }
    //   } catch (e) {
    //     emit(ProfileError("Não foi possível carregar as frases"));
    //   }
    // });

    on<LoadFrases>((event, emit) async {
      emit(FrasesLoading());
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final frasesSalvas = prefs.getString('frasesSalvas') ?? '';
        final List<String> frasesCarregadas = frasesSalvas.isNotEmpty ? frasesSalvas.split(';').cast<String>() : [];
        emit(FrasesLoaded(frasesCarregadas));
      } catch (e) {
        emit(ProfileError("Não foi possível carregar as frases"));
      }
    });

    on<SaveFrase>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final frasesSalvas = prefs.getString('frasesSalvas') ?? '';
      final novasFrases = frasesSalvas.isEmpty ? event.novaFrase : '$frasesSalvas;${event.novaFrase}';
      await prefs.setString('frasesSalvas', novasFrases);
      add(LoadFrases()); // Recarrega as frases após salvar
    });
  }
}

// class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
//   final ProfileRepository repository;

//   ProfileBloc({required this.repository}) : super(ProfileInitial()) {
//     on<LoadUserProfile>((event, emit) async {
//       print("Carregando perfil de usuário");
//       emit(ProfileLoading());
//       try {
//         final user = await repository.fetchUserProfile();
//         print("Perfil carregado: ${user.name}");
//         emit(ProfileLoaded(user));
//       } catch (e) {
//         print("Erro ao carregar perfil: $e");
//         emit(ProfileError("Não foi possível carregar o perfil"));
//       }
//     });
//     on<LoadFrases>((event, emit) async {
//       emit(FrasesLoading());
//       try {
//         final SharedPreferences prefs = await SharedPreferences.getInstance();
//         final frasesSalvas = prefs.getString('frasesSalvas') ?? '';
//         final List<String> frasesCarregadas = frasesSalvas.isNotEmpty ? frasesSalvas.split(';').cast<String>() : [];
//         emit(FrasesLoaded(frasesCarregadas));
//       } catch (e) {
//         emit(ProfileError("Não foi possível carregar as frases"));
//       }
//     });

//     on<SaveFrase>((event, emit) async {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final frasesSalvas = prefs.getString('frasesSalvas') ?? '';
//       final novasFrases = frasesSalvas.isEmpty ? event.novaFrase : '$frasesSalvas;${event.novaFrase}';
//       await prefs.setString('frasesSalvas', novasFrases);
//       add(LoadFrases()); // Recarrega as frases após salvar
//     });
//   }
// }
