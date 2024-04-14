import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'onboarding_animation_event.dart';
part 'onboarding_animation_state.dart';

class OnboardingAnimationBloc
    extends Bloc<OnboardingAnimationEvent, OnboardingAnimationState> {
  List<double> opacities;
  int index = 0;
  OnboardingAnimationBloc({required this.opacities})
      : super(
            OnboardingAnimationInitial(opacities: opacities, currentIndex: 0)) {
    on<OnNextClick>((event, emit) {
      if (index < 3) {
        index++;
        opacities[index] = 1;
        opacities[index - 1] = 0;
        emit(OnboardingAnimationChanged(
            opacities: opacities, currentIndex: index));
      }
    });
    on<OnPreviousClick>((event, emit) {
      if (index > 0) {
        index--;
        opacities[index] = 1;
        opacities[index + 1] = 0;
        emit(OnboardingAnimationChanged(
            opacities: opacities, currentIndex: index));
      }
    });
  }
}
