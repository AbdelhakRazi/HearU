// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'onboarding_animation_bloc.dart';

@immutable
sealed class OnboardingAnimationEvent {}

class OnNextClick extends OnboardingAnimationEvent {}

class OnPreviousClick extends OnboardingAnimationEvent {}
