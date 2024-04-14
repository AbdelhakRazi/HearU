import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'onboarding_animation_event.dart';
part 'onboarding_animation_state.dart';

class OnboardingAnimationBloc
    extends Bloc<OnboardingAnimationEvent, OnboardingAnimationState> {
  List<double> opacities;
  OnboardingAnimationBloc({required this.opacities})
      : super(OnboardingAnimationInitial(opacities: opacities)) {
    on<OnNextClick>((event, emit) {
      opacities[event.newIndex] = 1;
      opacities[event.newIndex - 1] = 0;
      emit(OnboardingAnimationChanged(opacities: opacities));
    });
    on<OnPreviousClick>((event, emit) {
      opacities[event.newIndex] = 1;
      opacities[event.newIndex + 1] = 0;
      emit(OnboardingAnimationChanged(opacities: opacities));
    });
  }
}
