import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged || event is PasswordChanged) {
      // You can add logic for validation here.
    }

    if (event is LoginSubmitted) {
      yield LoginLoading();
      await Future.delayed(Duration(seconds: 2)); // Simulate network delay

      yield LoginSuccess(); // Change to LoginFailure if login fails
    }
  }
}
