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