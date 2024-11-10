import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:go_router/go_router.dart';
import '../../services/shared_preferences.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GoRouter goRouter; // Pass GoRouter as a dependency

  SplashBloc(this.goRouter) : super(SplashInitial()) {
    on<CheckUserSession>(_onCheckUserSession);
  }

  /// Checks if the user is authenticated.
  Future<void> _onCheckUserSession(CheckUserSession event, Emitter<SplashState> emit) async {
    try {
      bool? isFirstTime = await _checkOnboarding();
      Future.delayed(const Duration(seconds: 1)).then(
        (value) {
          if (isFirstTime == true || isFirstTime == null) {
            goRouter.go('/login'); // Navigate to the welcome or onboarding screen
          } else {
            // _checkUserStatus();
          }
        },
      );
    } catch (e) {
      emit(SplashError("Failed to check user session."));
    }
  }

  /// Simulated session check (replace with actual authentication logic).
  Future<bool?> _checkOnboarding() async {
    try {
      bool? isFirstTime = SharedPrefsHelper().getBool("isFirstTime");
      return isFirstTime;
    } catch (e, stack) {
      log('Error----->>>>>$e');
      log('Stack----->>>>>$stack');
      return null;
    }
  }

  /// Simulated session check (replace with actual authentication logic).
  Future<bool?> _checkUserStatus() async {
    try {
      goRouter.go('/home'); // Navigate to the home screen for existing users
      return true;
    } catch (e, stack) {
      log('Error----->>>>>$e');
      log('Stack----->>>>>$stack');
      return null;
    }
  }
}
