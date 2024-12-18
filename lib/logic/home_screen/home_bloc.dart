import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetLocationEvent>(_onGetLocationEvent);
  }

  Future<void> _onGetLocationEvent(GetLocationEvent event, Emitter<HomeState> emit) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      Placemark place = await getAddressFromCoordinates(position.latitude, position.longitude);
      emit(HomeLocationState(place: place));
    } catch (e) {
      emit(HomeLocationError(e.toString()));
    }
  }

  Future<Placemark> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      print("Address: ${place.street}, ${place.locality}, ${place.country}");
      return place;
    } catch (e) {
      print("Error fetching address: $e");
      return Placemark();
    }
  }
}
