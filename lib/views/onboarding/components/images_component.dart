// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hearu/config/sizable_widgets.dart';
import 'package:hearu/state/onboarding_animation/onboarding_animation_bloc.dart';

import 'package:hearu/views/components/glassmorphic_background.dart';

import '../../../../config/assets.dart';

class ImagesComponent extends StatefulWidget {
  const ImagesComponent({
    super.key,
  });

  @override
  State<ImagesComponent> createState() => _ImagesComponentState();
}

class _ImagesComponentState extends State<ImagesComponent> {
  @override
  Widget build(BuildContext context) {
    return GlassmorphicBackground(
        child: Column(
      children: [
        SvgPicture.asset(
          Assets.logo,
          height: 36,
          width: 36,
        ),
        Flexible(
          child: BlocBuilder<OnboardingAnimationBloc, OnboardingAnimationState>(
            builder: (context, state) {
              return Stack(
                  children: List.generate(
                Assets.onboardingImages.length,
                (index) => Positioned(
                  top: 0,
                  bottom: 0,
                  child: AnimatedOpacity(
                    opacity: state.opacities[index],
                    duration: const Duration(milliseconds: 300),
                    child: Image.asset(
                        "assets/images/${Assets.onboardingImages[index]}"),
                  ),
                ),
              ));
            },
          ),
        ),
      ],
    ));
  }
}
