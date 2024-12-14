import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/api_service.dart';
import '../../services/shared_preferences.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GoRouter goRouter; // Pass GoRouter as a dependency
  final ApiService _apiService = ApiService();

  SplashBloc(this.goRouter) : super(SplashInitial()) {
    on<CheckUserSession>(_onCheckUserSession);
  }

  /// Checks if the user is authenticated.
  Future<void> _onCheckUserSession(CheckUserSession event, Emitter<SplashState> emit) async {
    try {
      bool? isFirstTime = await _checkOnboarding();
      // Future.delayed(const Duration(seconds: 1)).then(
      //   (value) {
          if (isFirstTime == true || isFirstTime == null) {
            goRouter.go('/onBoarding');
          } else {
            _checkUserStatus();
          }
        // },
      // );
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
  void _checkUserStatus() async {
    try {
      if (   SharedPrefsHelper().getString("authToken") != null ||  SharedPrefsHelper().getString("authToken") != ''){
        final response = await _apiService.get('auth/checkUser', auth: true);
        ///if want to force logout
        // response?.statusCode = 100;
        if (response != null && response.statusCode == 200) {
          if (response.data['user']['isProfileSetup'] == true) {
            goRouter.go('/home');
          } else {
            goRouter.go('/profileSetup');
          }
        } else {
          SharedPrefsHelper().clearAll();
          goRouter.go('/login');
          log('Failed to fetch user details');
        }
      }
    } catch (e, stack) {
      log('Error----->>>>>$e');
      log('Stack----->>>>>$stack');
      goRouter.go('/login');
    }
  }
}
