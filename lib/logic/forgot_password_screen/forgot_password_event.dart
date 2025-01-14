abstract class ForgotPasswordEvent {}

class EnterEmailEvent extends ForgotPasswordEvent {
  final String email;

  EnterEmailEvent(this.email);
}

class VerifyOtpEvent extends ForgotPasswordEvent {
  final String otp;
  final String email;

  VerifyOtpEvent(this.otp, this.email);
}

class ChangePasswordEvent extends ForgotPasswordEvent {
  final String newPassword;
  final String confirmPassword;
  final String email;

  ChangePasswordEvent(this.newPassword, this.confirmPassword, this.email);
}
