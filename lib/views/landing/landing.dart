import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hearu/config/assets.dart';

import '../components/glassmorphic_background.dart';
import 'components/navigation_component.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

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
                child: GlassmorphicBackground(
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.logo,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ))),
        Positioned(
            bottom: 0,
            child: SizedBox(
                height: screenSize.height * 0.4,
                width: screenSize.width,
                child: const NavigationComponent()))
      ],
    ));
  }
}
