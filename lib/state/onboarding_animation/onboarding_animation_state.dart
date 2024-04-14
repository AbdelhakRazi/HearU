part of 'onboarding_animation_bloc.dart';

@immutable
sealed class OnboardingAnimationState {
  final List<double> opacities;
  const OnboardingAnimationState({required this.opacities});
}

final class OnboardingAnimationInitial extends OnboardingAnimationState {
  const OnboardingAnimationInitial({required super.opacities});
}

class OnboardingAnimationChanged extends OnboardingAnimationState {
  const OnboardingAnimationChanged({required super.opacities});
}
