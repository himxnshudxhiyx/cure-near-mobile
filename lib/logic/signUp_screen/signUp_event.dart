import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EmailChanged extends SignUpEvent {
  final String email;

  EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}
class NameChanged extends SignUpEvent {
  final String fullName;

  NameChanged(this.fullName);

  @override
  List<Object> get props => [fullName];
}

class PasswordChanged extends SignUpEvent {
  final String password;

  PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class SignUpSubmitted extends SignUpEvent {
  final String email;
  final String password;
  final String fullName;

  SignUpSubmitted({required this.email, required this.password, required this.fullName});

  @override
  List<Object> get props => [email, password, fullName];
}