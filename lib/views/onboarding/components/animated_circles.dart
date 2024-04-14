import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearu/config/colors.dart';
import 'package:hearu/config/measures.dart';
import 'package:hearu/state/onboarding_animation/onboarding_animation_bloc.dart';

class AnimatedCircles extends StatefulWidget {
  const AnimatedCircles({super.key});

  @override
  State<AnimatedCircles> createState() => _AnimatedCirclesState();
}

class _AnimatedCirclesState extends State<AnimatedCircles> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingAnimationBloc, OnboardingAnimationState>(
      builder: (context, state) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                4,
                (index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Measures.smallPadding / 2),
                      child: CircleAvatar(
                        child: null,
                        maxRadius: 6,
                        backgroundColor: index <= state.currentIndex
                            ? AppColors.blueMain
                            : AppColors.lightGrey,
                      ),
                    )));
      },
    );
  }
}
