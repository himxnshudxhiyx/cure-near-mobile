import 'package:bloc/bloc.dart';
import 'package:cure_near/logic/search_bar/search_bar_event.dart';
import 'package:cure_near/logic/search_bar/search_bar_state.dart';

class SearchBloc extends Bloc<SearchBarEvent, SearchBarState> {
  SearchBloc() : super(SearchBarInitial()) {
    // Handle SearchStarted event
    on<SearchStarted>((event, emit) {
      emit(SearchBarStarted());
    });

    // Handle SearchFinished event
    on<SearchFinished>((event, emit) {
      try {
        // Emit the finished state with potential results (if needed)
        emit(SearchBarFinished());
      } catch (e) {
        emit(SearchBarError("An error occurred while finishing the search."));
      }
    });
  }
}
