abstract class ForgotPasswordEvent {}

class EnterEmailEvent extends ForgotPasswordEvent {
  final String email;

  EnterEmailEvent(this.email);
}

class VerifyOtpEvent extends ForgotPasswordEvent {
  final String otp;

  VerifyOtpEvent(this.otp);
}

class ChangePasswordEvent extends ForgotPasswordEvent {
  final String newPassword;
  final String confirmPassword;

  ChangePasswordEvent(this.newPassword, this.confirmPassword);
}
