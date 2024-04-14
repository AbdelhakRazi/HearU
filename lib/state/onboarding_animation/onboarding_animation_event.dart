// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'onboarding_animation_bloc.dart';

@immutable
sealed class OnboardingAnimationEvent {}

class OnNextClick extends OnboardingAnimationEvent {
  final int newIndex;
  OnNextClick({
    required this.newIndex,
  });
}

class OnPreviousClick extends OnboardingAnimationEvent {
  final int newIndex;
  OnPreviousClick({
    required this.newIndex,
  });
}
