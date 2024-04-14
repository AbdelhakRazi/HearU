part of 'onboarding_animation_bloc.dart';

@immutable
sealed class OnboardingAnimationState {
  final List<double> opacities;
  final int currentIndex;
  const OnboardingAnimationState(
      {required this.currentIndex, required this.opacities});
}

final class OnboardingAnimationInitial extends OnboardingAnimationState {
  const OnboardingAnimationInitial(
      {required super.opacities, required super.currentIndex});
}

class OnboardingAnimationChanged extends OnboardingAnimationState {
  const OnboardingAnimationChanged(
      {required super.opacities, required super.currentIndex});
}
