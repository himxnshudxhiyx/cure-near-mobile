import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {
  final int currentPage;
  const OnboardingInitial(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

class OnboardingComplete extends OnboardingState {}
