import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/api_service.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService _apiService = ApiService();

  LoginBloc() : super(LoginInitial()){
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  // Event handler for LoginSubmitted
  Future<void> _onLoginSubmitted(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading()); // Show loading spinner when API call starts

    try {
      // Make the API call for login
      final response = await callLoginApi(event.email, event.password);

      // Check the response
      if (response != null && response.statusCode == 200) {
        emit(LoginSuccess(response.data));
      } else {
        emit(LoginFailure('Invalid credentials'));
      }
    } catch (e) {
      emit(LoginFailure('An error occurred during login: ${e.toString()}'));
    }
  }

  callLoginApi(String email, String password) async {
    final data = {
      'username': email,
      'password': password,
    };

    return await _apiService.post('auth/login', data: data);
  }
}
