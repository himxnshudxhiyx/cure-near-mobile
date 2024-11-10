abstract class SplashState {}

/// Initial state when the splash screen is first displayed.
class SplashInitial extends SplashState {}

/// State when resources are being loaded.
class SplashLoading extends SplashState {}

/// State to indicate that the user is authenticated and can proceed to the home screen.
class Authenticated extends SplashState {}

/// State to indicate that the user is not authenticated and should be directed to the login screen.
class Unauthenticated extends SplashState {}

/// State when an error occurs during initialization.
class SplashError extends SplashState {
  final String message;

  SplashError(this.message);
}
