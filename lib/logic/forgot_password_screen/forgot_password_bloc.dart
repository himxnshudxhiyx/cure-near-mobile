import 'package:flutter_bloc/flutter_bloc.dart';

import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitialState()) {
    on<EnterEmailEvent>((event, emit) async {
      emit(EmailSubmittingState());
      try {
        // Simulate API call for email submission
        await Future.delayed(const Duration(seconds: 2));
        emit(EmailSubmittedState());
      } catch (e) {
        emit(ForgotPasswordErrorState("Failed to submit email."));
      }
    });

    on<VerifyOtpEvent>((event, emit) async {
      emit(OtpSubmittingState());
      try {
        // Simulate API call for OTP verification
        await Future.delayed(const Duration(seconds: 2));
        emit(OtpVerifiedState());
      } catch (e) {
        emit(ForgotPasswordErrorState("Failed to verify OTP."));
      }
    });

    on<ChangePasswordEvent>((event, emit) async {
      emit(PasswordChangingState());
      try {
        if (event.newPassword != event.confirmPassword) {
          throw Exception("Passwords do not match.");
        }
        // Simulate API call for password change
        await Future.delayed(const Duration(seconds: 2));
        emit(PasswordChangedState());
      } catch (e) {
        emit(ForgotPasswordErrorState(e.toString()));
      }
    });
  }
}
