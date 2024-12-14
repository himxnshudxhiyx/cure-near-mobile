import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());

  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadHomeData) {
      yield HomeLoading();
      try {
        // Simulate fetching data
        await Future.delayed(const Duration(seconds: 2));
        yield HomeLoaded("Fetched data successfully");
      } catch (e) {
        yield HomeError("Failed to load data");
      }
    } else if (event is UpdateHomeData) {
      yield HomeLoaded(event.newData);
    }
  }
}