import 'dart:developer';

import 'package:cure_near/logic/profile_setup_screen/profile_setup_event.dart';
import 'package:cure_near/logic/profile_setup_screen/profile_setup_state.dart';
import 'package:cure_near/services/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../services/api_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ApiService _apiService = ApiService();

  ProfileBloc() : super(ProfileInitial()) {
    on<UserCheckRequested>(
      (event, emit) async {
        emit(ProfileLoading());
        try {
          final response = await _apiService.get('auth/checkUser', auth: true);
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

    on<ProfilePageRefresh>((event, emit) {
      emit(ProfileRefreshing());
      emit(state);
    });

    on<ProfileSubmitted>(
      (event, emit) async {
        emit(ProfileSubmitting());

        try {
          String userId = SharedPrefsHelper().getString('userId') ?? '';
          final response = await callProfileSetupApi(event.phoneNumber.toString(), event.dateOfBirth.toString(), event.gender.toString(), userId);

          // Check the response
          if (response != null && response.statusCode == 200) {
            Fluttertoast.showToast(msg: 'Profile Setup Successfully, taking you to home page');
            emit(ProfileUpdated());
          } else {
            emit(ProfileFailure('Failed to update profile: ${response.data['message']}'));
          }
        } catch (error) {
          emit(ProfileFailure('Failed to update profile: ${error.toString()}'));
        }
      },
    );
  }

  callProfileSetupApi(String phoneNumber, String dateOfBirth, String gender, String userId) async {
    final data = {
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'userId': userId,
    };

    return await _apiService.post('auth/profile-setup', data: data, auth: true);
  }

}
