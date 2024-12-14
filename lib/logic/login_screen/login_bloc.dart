import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/api_service.dart';
import 'login_event.dart';
import 'login_state.dart';

/// LoginBloc handles login events and states.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService _apiService = ApiService();

  // Initial state is LoginInitial
  LoginBloc() : super(LoginInitial()) {
    // Handle LoginSubmitted event
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  /// Event handler for login submission.
  Future<void> _onLoginSubmitted(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading()); // Emit loading state while API call is in progress

    try {
      // Call the login API
      final response = await _callLoginApi(event.email, event.password);

      // Check if response is successful
      if (response != null && response.statusCode == 200) {
        emit(LoginSuccess(response.data)); // Emit success state
      } else {
        emit(LoginFailure('Invalid credentials')); // Emit failure state on invalid response
      }
    } catch (e) {
      emit(LoginFailure('An error occurred during login: ${e.toString()}')); // Emit failure on error
    }
  }

  /// Makes the login API call.
  Future<dynamic> _callLoginApi(String email, String password) async {
    final data = {
      'username': email,
      'password': password,
    };
    // Send a POST request to the login API
    return await _apiService.post('auth/login', data: data);
  }
}
