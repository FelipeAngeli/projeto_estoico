import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_estoico/app/bloc/settings/settings_event.dart';
import 'package:projeto_estoico/app/bloc/settings/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<LoadUserSettings>(_onLoadUserSettings);
    on<UpdateUserSettings>(_onUpdateUserSettings);
  }

  Future<void> _onLoadUserSettings(LoadUserSettings event, Emitter<SettingsState> emit) async {
    try {
      emit(SettingsLoading());
      // Simulação de obtenção de dados do usuário
      await Future.delayed(const Duration(seconds: 1)); // Simula carregamento de dados
      emit(const SettingsLoaded(name: "João", email: "joao@example.com", password: "securepassword123"));
    } catch (error) {
      emit(SettingsError(error.toString()));
    }
  }

  Future<void> _onUpdateUserSettings(UpdateUserSettings event, Emitter<SettingsState> emit) async {
    try {
      emit(SettingsLoading());
      // Aqui você atualizaria os dados do usuário
      await Future.delayed(const Duration(seconds: 1)); // Simula a atualização dos dados
      emit(SettingsLoaded(name: event.name, email: event.email, password: event.password));
    } catch (error) {
      emit(SettingsError(error.toString()));
    }
  }
}
