import 'package:geocoding/geocoding.dart';

abstract class ProfileScreenState {}

class ProfileInitial extends ProfileScreenState {}

class ProfileLoading extends ProfileScreenState {}

class ProfileLoaded extends ProfileScreenState {
}

class ProfileError extends ProfileScreenState {
  final String message;

  ProfileError(this.message);
}