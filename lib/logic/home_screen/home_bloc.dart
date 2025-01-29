import 'package:cure_near/models/hospital_category_model/hospital_category_model.dart';
import 'package:cure_near/models/hospital_category_model/nearby_hospitals_model.dart';
import 'package:cure_near/services/logger_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../services/api_service.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetLocationEvent>(_onGetLocationEvent);
    on<GetHospitalCatEvent>(_getHospitalCatEvent);
    on<GetNearbyHospitalEvent>(_getNearbyHospitals);
  }

  _getHospitalCatEvent(GetHospitalCatEvent event, Emitter<HomeState> emit) async {
    try {
      final response = await ApiService().post('hospitals/getHospitalCategories', auth: true);

      if (response != null && response.statusCode == 200) {
        final List<HospitalCategoryDataModel> hospitalCategories = (response.data['data'] as List).map((e) => HospitalCategoryDataModel.fromJson(e)).toList();

        final currentState = state is HomeUpdatedState ? state as HomeUpdatedState : HomeUpdatedState();
        emit(currentState.copyWith(hospitalCategories: hospitalCategories));
      } else {
        emit(HomeUpdatedState(hospitalCategories: []));
      }
    } catch (e) {
      emit(HomeUpdatedState(hospitalCategories: []));
    }
  }

  _getNearbyHospitals(GetNearbyHospitalEvent event, Emitter<HomeState> emit) async {
    try {
      final response =
          await ApiService().post('hospitals/getNearbyHospitals', auth: true, data: {"lat": "28.9945832", "long": "77.0281157", "search": "", "cat": ""});

      if (response != null && response.statusCode == 200) {
        final List<NearbyHospitalsDataModel> nearByHospitals = (response.data['data'] as List).map((e) => NearbyHospitalsDataModel.fromJson(e)).toList();

        final currentState = state is HomeUpdatedState ? state as HomeUpdatedState : HomeUpdatedState();
        emit(currentState.copyWith(nearByHospitals: nearByHospitals));
      } else {
        emit(HomeUpdatedState(hospitalCategories: []));
      }
    } catch (e) {
      emit(HomeUpdatedState(hospitalCategories: []));
    }
  }

  Future<void> _onGetLocationEvent(GetLocationEvent event, Emitter<HomeState> emit) async {
    try {
      PermissionStatus locPermissionStatus = await Permission.location.request();

      if (locPermissionStatus.isGranted) {
        Position position = await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
        );

        Placemark place = await getAddressFromCoordinates(position.latitude, position.longitude);

        final currentState = state is HomeUpdatedState ? state as HomeUpdatedState : HomeUpdatedState();
        emit(currentState.copyWith(place: place));
      } else if (locPermissionStatus.isDenied) {
        final currentState = state is HomeUpdatedState ? state as HomeUpdatedState : HomeUpdatedState();
        emit(currentState.copyWith(locationError: 'Location permission denied by user.'));
      } else if (locPermissionStatus.isPermanentlyDenied) {
        final currentState = state is HomeUpdatedState ? state as HomeUpdatedState : HomeUpdatedState();
        emit(currentState.copyWith(locationError: 'Location permission permanently denied. Please enable it from settings.'));
        openAppSettings();
      }
    } catch (e) {
      final currentState = state is HomeUpdatedState ? state as HomeUpdatedState : HomeUpdatedState();
      emit(currentState.copyWith(locationError: 'Error getting location: ${e.toString()}'));
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
