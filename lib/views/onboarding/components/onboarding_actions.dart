import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearu/config/assets.dart';
import 'package:hearu/config/colors.dart';
import 'package:hearu/config/measures.dart';
import 'package:hearu/state/onboarding_animation/onboarding_animation_bloc.dart';
import 'package:hearu/views/onboarding/components/animated_action_buttons.dart';

class OnBoardingActions extends StatefulWidget {
  const OnBoardingActions({super.key});

  @override
  State<OnBoardingActions> createState() => _OnBoardingActionsState();
}

class _OnBoardingActionsState extends State<OnBoardingActions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Measures.basicRadius),
          color: AppColors.white),
      padding: const EdgeInsets.only(
          left: Measures.leftRightPadding,
          right: Measures.leftRightPadding,
          bottom: Measures.topBottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child:
                BlocBuilder<OnboardingAnimationBloc, OnboardingAnimationState>(
              builder: (context, state) {
                return Stack(
                    children: List.generate(
                  Assets.onboardingTitles.length,
                  (index) => Positioned(
                    left: 0,
                    child: AnimatedOpacity(
                      opacity: state.opacities[index],
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        Assets.onboardingTitles[index],
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ));
              },
            ),
          ),
          Flexible(
            child:
                BlocBuilder<OnboardingAnimationBloc, OnboardingAnimationState>(
              builder: (context, state) {
                return Stack(
                    children: List.generate(
                  Assets.onboardingTitles.length,
                  (index) => Positioned(
                    left: 0,
                    child: AnimatedOpacity(
                      opacity: state.opacities[index],
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        Assets.onboardingBody[index],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ));
              },
            ),
          ),
          const Spacer(),
          const Expanded(flex: 2, child: AnimatedActionButtons()),
          const Spacer(),
        ],
      ),
    );
  }
}
