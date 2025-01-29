import 'package:cure_near/models/hospital_category_model/hospital_category_model.dart';
import 'package:geocoding/geocoding.dart';

import '../../models/hospital_category_model/nearby_hospitals_model.dart';

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

class HospitalCatStateSuccess extends HomeState {
  final List<HospitalCategoryDataModel> hospitalCategories;

  HospitalCatStateSuccess(this.hospitalCategories);
}

class HospitalCatStateError extends HomeState {
  final String message;

  HospitalCatStateError(this.message);
}

class HomeUpdatedState extends HomeState {
  final List<HospitalCategoryDataModel> hospitalCategories;
  final List<NearbyHospitalsDataModel> nearByHospitals;
  final Placemark? place;
  final String? locationError;

  HomeUpdatedState({
    this.hospitalCategories = const [],
    this.nearByHospitals = const [],
    this.place,
    this.locationError,
  });

  HomeUpdatedState copyWith({
    List<HospitalCategoryDataModel>? hospitalCategories,
    List<NearbyHospitalsDataModel>? nearByHospitals,
    Placemark? place,
    String? locationError,
  }) {
    return HomeUpdatedState(
      hospitalCategories: hospitalCategories ?? this.hospitalCategories,
      nearByHospitals: nearByHospitals ?? this.nearByHospitals,
      place: place ?? this.place,
      locationError: locationError, // Override only if an error occurs
    );
  }
}
