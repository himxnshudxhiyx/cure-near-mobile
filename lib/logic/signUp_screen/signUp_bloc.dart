import 'package:cure_near/logic/signUp_screen/signUp_event.dart';
import 'package:cure_near/logic/signUp_screen/signUp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/api_service.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final ApiService _apiService = ApiService();

  SignUpBloc() : super(SignUpInitial()){
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  // Event handler for SignUpSubmitted
  Future<void> _onSignUpSubmitted(
      SignUpSubmitted event,
      Emitter<SignUpState> emit,
      ) async {
    emit(SignUpLoading()); // Show loading spinner when API call starts

    try {
      // Make the API call for SignUp
      final response = await callSignUpApi(event.email, event.password);

      // Check the response
      if (response != null && response.statusCode == 200) {
        emit(SignUpSuccess(response.data)); // Pass the response data to success state
      } else {
        emit(SignUpFailure('Invalid credentials')); // Handle failure
      }
    } catch (e) {
      emit(SignUpFailure('An error occurred during SignUp: ${e.toString()}'));
    }
  }

  callSignUpApi(String email, String password) async {
    final data = {
      'username': email,
      'password': password,
    };

    return await _apiService.post('auth/SignUp', data: data);
  }
}
