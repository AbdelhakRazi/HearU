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
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: TextButton(
            onPressed: () {
              index--;
              BlocProvider.of<OnboardingAnimationBloc>(context)
                  .add(OnPreviousClick(newIndex: index));
            },
            child: const Text("Skip", style: TextStyle(color: AppColors.dark)),
          ),
        ),
        Flexible(
          child: ActionOutlinedButton.withIcon(
            onPressed: () {
              index++;
              BlocProvider.of<OnboardingAnimationBloc>(context)
                  .add(OnNextClick(newIndex: index));
            },
            trailingIcon: FontAwesomeIcons.arrowRightLong,
            text: 'Next',
          ),
        )
      ],
    );
  }
}
