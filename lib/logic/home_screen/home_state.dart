import 'package:geocoding/geocoding.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final String data;

  HomeLoaded(this.data);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}

class HomeLocationError extends HomeState {
  final String message;

  HomeLocationError(this.message);
}

class HomeLocationState extends HomeState {
  final Placemark place;

  HomeLocationState({required this.place});
}
