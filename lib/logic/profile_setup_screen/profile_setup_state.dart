abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSubmitting extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final String name;
  final String email;
  final String phoneNumber;
  final DateTime? dateOfBirth;
  final String gender;

  ProfileSuccess({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.dateOfBirth,
    required this.gender,
  });

  // Implement the copyWith method
  ProfileSuccess copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? gender,
  }) {
    return ProfileSuccess(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
    );
  }
}

class ProfileUpdated extends ProfileState {}

class ProfileFailure extends ProfileState {
  final String errorMessage;

  ProfileFailure(this.errorMessage);

  List<Object> get props => [errorMessage];
}
