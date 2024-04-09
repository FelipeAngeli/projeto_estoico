import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/bloc/profile/profile_bloc.dart';
import 'package:projeto_estoico/app/bloc/profile/profile_events.dart';

class ProfileController {
  final profileBloc = Modular.get<ProfileBloc>();

  void loadUserProfile() {
    profileBloc.add(LoadUserProfile());
  }
}
