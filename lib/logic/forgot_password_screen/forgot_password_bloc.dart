import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/api_service.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitialState()) {
    on<EnterEmailEvent>((event, emit) async {
      emit(EmailSubmittingState());
      try {
        final response = await ApiService().post('auth/forgotPassword', auth: false, data: {'username': event.email});
        if (response != null) {
          if (response.statusCode == 200) {
            Fluttertoast.showToast(msg: response.data['message']);
            emit(EmailSubmittedState());
          } else {
            emit(ForgotPasswordErrorState("Failed to submit email."));
          }
        } else {
          emit(ForgotPasswordErrorState("Failed to submit email."));
        }
      } catch (e) {
        emit(ForgotPasswordErrorState("Failed to submit email."));
      }
    });

    on<VerifyOtpEvent>((event, emit) async {
      emit(OtpSubmittingState());
      try {
        final response = await ApiService().post('auth/verifyEmailOtp', auth: false, data: {'username': event.email, "otp": event.otp});
        if (response != null) {
          if (response.statusCode == 200) {
            Fluttertoast.showToast(msg: response.data['message']);
            emit(OtpVerifiedState());
          } else {
            emit(ForgotPasswordErrorState("Failed to verify OTP."));
          }
        } else {
          emit(ForgotPasswordErrorState("Failed to verify OTP."));
        }
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

        final response = await ApiService().post('auth/changePassword', auth: false, data: {'username': event.email, "password": event.newPassword});
        if (response != null) {
          if (response.statusCode == 200) {
            Fluttertoast.showToast(msg: response.data['message']);
            emit(PasswordChangedState());
          } else {
            emit(ForgotPasswordErrorState('Password not changed'));
          }
        } else {
          emit(ForgotPasswordErrorState('Password not changed'));
        }
      } catch (e) {
        emit(ForgotPasswordErrorState(e.toString()));
      }
    });
  }
}
