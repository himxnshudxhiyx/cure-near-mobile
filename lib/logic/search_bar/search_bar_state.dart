abstract class SearchBarState {}

class SearchBarInitial extends SearchBarState {}

class SearchBarStarted extends SearchBarState {}

class SearchBarFinished extends SearchBarState {
  SearchBarFinished();
}

class SearchBarError extends SearchBarState {
  final String message;

  SearchBarError(this.message);
}
