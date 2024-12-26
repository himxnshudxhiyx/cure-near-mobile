import 'package:cure_near/services/logger_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetLocationEvent>(_onGetLocationEvent);
  }

  Future<void> _onGetLocationEvent(GetLocationEvent event, Emitter<HomeState> emit) async {
    try {
      PermissionStatus locPermissionStatus = await Permission.location.request();

      if (locPermissionStatus.isGranted) {
        Position position = await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(
            accuracy: LocationAccuracy.high,
          ),
        );

        Placemark place = await getAddressFromCoordinates(position.latitude, position.longitude);

        emit(HomeLocationState(place: place));
      } else if (locPermissionStatus.isDenied) {
        Logger.logObject(object: 'Location permission denied by user.');
        emit(HomeLocationError('Location permission denied by user.'));
      } else if (locPermissionStatus.isPermanentlyDenied) {
        Logger.logObject(object: 'Location permission permanently denied.');
        emit(HomeLocationError('Location permission permanently denied. Please enable it from settings.'));
        openAppSettings();
      }
    } catch (e) {
      // Logger.logObject(object: 'Error getting location ${e.toString()}');
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
      Logger.logObject(object: 'Error getting address ${e.toString()}');
      return Placemark();
    }
  }
}
