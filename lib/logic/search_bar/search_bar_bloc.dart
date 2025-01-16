import 'package:bloc/bloc.dart';
import 'package:cure_near/logic/search_bar/search_bar_event.dart';
import 'package:cure_near/logic/search_bar/search_bar_state.dart';
import 'package:cure_near/services/logger_service.dart';

class SearchBloc extends Bloc<SearchBarEvent, SearchBarState> {
  SearchBloc() : super(SearchBarInitial()) {
    on<SearchStarted>((event, emit) {
      try {
        Logger.logObject(object: 'Search Emitted');
        emit(SearchBarStarted());
        Logger.logObject(object: 'Search SearchBarStarted Emitted');
      } catch (e) {
        Logger.logObject(object: 'Error is $e');
      }
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
