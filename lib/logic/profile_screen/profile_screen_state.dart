abstract class ProfileScreenState {}

class ProfileInitialState extends ProfileScreenState {}

class ProfileLoadingState extends ProfileScreenState {}

class ProfileLoadedState extends ProfileScreenState {
  final String name;
  final String email;
  final String phone;

  ProfileLoadedState({
    required this.name,
    required this.email,
    required this.phone,
  });
}

class ProfileErrorState extends ProfileScreenState {
  final String message;

  ProfileErrorState(this.message);
}
