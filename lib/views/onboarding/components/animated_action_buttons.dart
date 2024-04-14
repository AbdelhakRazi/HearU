import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hearu/config/colors.dart';
import 'package:hearu/state/onboarding_animation/onboarding_animation_bloc.dart';
import 'package:hearu/views/components/action_outlined_button.dart';

class AnimatedActionButtons extends StatefulWidget {
  const AnimatedActionButtons({super.key});

  @override
  State<AnimatedActionButtons> createState() => _AnimatedActionButtonsState();
}

class _AnimatedActionButtonsState extends State<AnimatedActionButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: TextButton(
            onPressed: () {
              BlocProvider.of<OnboardingAnimationBloc>(context)
                  .add(OnPreviousClick());
            },
            child: const Text("Skip", style: TextStyle(color: AppColors.dark)),
          ),
        ),
        Flexible(
          child: ActionOutlinedButton.withIcon(
            onPressed: () {
              BlocProvider.of<OnboardingAnimationBloc>(context)
                  .add(OnNextClick());
            },
            trailingIcon: FontAwesomeIcons.arrowRightLong,
            text: 'Next',
          ),
        )
      ],
    );
  }
}
