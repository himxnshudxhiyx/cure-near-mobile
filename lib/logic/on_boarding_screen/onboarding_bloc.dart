import 'package:bloc/bloc.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingInitial(0)) {
    on<NextPageEvent>((event, emit) {
      if (state is OnboardingInitial) {
        final currentPage = (state as OnboardingInitial).currentPage;
        if (currentPage < 2) {
          emit(OnboardingInitial(currentPage + 1));
        } else {
          emit(OnboardingComplete());
        }
      }
    });

    on<PreviousPageEvent>((event, emit) {
      if (state is OnboardingInitial) {
        final currentPage = (state as OnboardingInitial).currentPage;
        if (currentPage > 0) {
          emit(OnboardingInitial(currentPage - 1));
        }
      }
    });

    on<CompleteOnboardingEvent>((event, emit) {
      emit(OnboardingComplete());
    });
  }
}
