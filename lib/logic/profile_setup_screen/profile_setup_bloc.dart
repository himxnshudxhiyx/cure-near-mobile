import 'dart:developer';

import 'package:cure_near/logic/profile_setup_screen/profile_setup_event.dart';
import 'package:cure_near/logic/profile_setup_screen/profile_setup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/api_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ApiService _apiService = ApiService();

  ProfileBloc() : super(ProfileInitial()) {
    on<UserCheckRequested>(
      (event, emit) async {
        emit(ProfileLoading());
        try {
          final response = await _apiService.get('auth/checkUser');
          if (response != null && response.statusCode == 200) {
            final data = response.data;
            emit(ProfileSuccess(
              name: data['user']['fullname'] ?? '',
              email: data['user']['username'] ?? '',
              phoneNumber: '',
              dateOfBirth: null,
              gender: '',
            ));
          } else {
            log('Failed to fetch user details');
            emit(ProfileFailure('Failed to fetch user details.'));
          }
        } catch (e) {
          log('Error: ${e.toString()}');
          emit(ProfileFailure('An error occurred: ${e.toString()}'));
        }
      },
    );

    on<DateOfBirthChanged>((event, emit) {
      try{
        log(state.toString());
        emit(state is ProfileSuccess
            ? (state as ProfileSuccess).copyWith(dateOfBirth: event.dateOfBirth)
            : state);
      } catch (e, stack) {
        log('Error $e');
        log('Stack $stack');
      }
    });

    on<GenderChanged>((event, emit) {
      emit(state is ProfileSuccess
          ? (state as ProfileSuccess).copyWith(gender: event.gender)
          : state);
    });

    on<ProfileSubmitted>(
      (event, emit) async {
        emit(ProfileLoading());

        try {
          // Simulate a network call
          await Future.delayed(const Duration(seconds: 2));

          emit(ProfileUpdated());
        } catch (error) {
          emit(ProfileFailure('Failed to update profile: ${error.toString()}'));
        }
      },
    );
  }
}
