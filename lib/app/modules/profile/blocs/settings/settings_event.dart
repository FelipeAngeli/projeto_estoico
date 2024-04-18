abstract class SettingsEvent {}

class LoadUserSettings extends SettingsEvent {}

class UpdateUserSettings extends SettingsEvent {
  final String name;
  final String email;
  final String password;

  UpdateUserSettings(this.name, this.email, this.password);
}
