abstract class ForgotPasswordState {}

class ForgotPasswordInitialState extends ForgotPasswordState {}

class EmailSubmittingState extends ForgotPasswordState {}

class EmailSubmittedState extends ForgotPasswordState {}

class OtpSubmittingState extends ForgotPasswordState {}

class OtpVerifiedState extends ForgotPasswordState {}

class PasswordChangingState extends ForgotPasswordState {}

class PasswordChangedState extends ForgotPasswordState {}

class ForgotPasswordErrorState extends ForgotPasswordState {
  final String message;

  ForgotPasswordErrorState(this.message);
}
