import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_estoico/app/modules/profile/blocs/settings/settings_event.dart';
import 'package:projeto_estoico/app/modules/profile/blocs/settings/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<LoadUserSettings>(_onLoadUserSettings);
    on<UpdateUserSettings>(_onUpdateUserSettings);
  }

  Future<void> _onLoadUserSettings(LoadUserSettings event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    await Future.delayed(const Duration(seconds: 1)); // Simula carregamento
    emit(SettingsLoaded(name: "João", email: "joao@example.com", password: "securepassword123"));
  }

  Future<void> _onUpdateUserSettings(UpdateUserSettings event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    await Future.delayed(const Duration(seconds: 1)); // Simula a atualização dos dados
    emit(SettingsLoaded(name: event.name, email: event.email, password: event.password));
  }
}
