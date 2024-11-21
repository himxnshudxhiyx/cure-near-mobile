abstract class ProfileEvent {}

class NameChanged extends ProfileEvent {
  final String name;

  NameChanged(this.name);
}

class EmailChanged extends ProfileEvent {
  final String email;

  EmailChanged(this.email);
}

class PhoneNumberChanged extends ProfileEvent {
  final String phoneNumber;

  PhoneNumberChanged(this.phoneNumber);
}

class DateOfBirthChanged extends ProfileEvent {
  final DateTime dateOfBirth;

  DateOfBirthChanged(this.dateOfBirth);
}

class GenderChanged extends ProfileEvent {
  final String gender;

  GenderChanged(this.gender);
}

class ProfileSubmitted extends ProfileEvent {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String? gender;

  ProfileSubmitted({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.dateOfBirth,
    required this.gender,
  });
}

class UserCheckRequested extends ProfileEvent {}
