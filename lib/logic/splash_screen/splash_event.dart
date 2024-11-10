abstract class SplashEvent {}

/// Triggered when the splash screen is shown.
class SplashStarted extends SplashEvent {}

/// Triggered when resources like app settings, user data, etc., are loaded.
class LoadResources extends SplashEvent {}

/// Triggered to check if the user is already authenticated.
class CheckUserSession extends SplashEvent {}

/// Triggered to move to the next screen after the splash.
class NavigateToNextScreen extends SplashEvent {}
