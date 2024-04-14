import 'package:flutter/material.dart';
import 'package:hearu/views/onboarding/components/images_component.dart';
import 'package:hearu/views/onboarding/components/onboarding_actions.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            top: 0,
            child: SizedBox(
                height: screenSize.height * 0.63,
                width: screenSize.width,
                child: const ImagesComponent())),
        Positioned(
            bottom: 0,
            child: SizedBox(
                height: screenSize.height * 0.37,
                width: screenSize.width,
                child: const OnBoardingActions()))
      ],
    ));
  }
}
