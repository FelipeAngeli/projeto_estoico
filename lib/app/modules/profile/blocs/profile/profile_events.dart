abstract class ProfileEvent {}

class LoadUserProfile extends ProfileEvent {}

class LoadFrases extends ProfileEvent {}

class SaveFrase extends ProfileEvent {
  final String novaFrase;

  SaveFrase(this.novaFrase);
}
