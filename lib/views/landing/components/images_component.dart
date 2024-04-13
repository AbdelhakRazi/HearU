import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hearu/config/colors.dart';
import 'package:hearu/views/components/glassmorphism_container.dart';

import '../../../config/assets.dart';

class ImagesComponent extends StatelessWidget {
  const ImagesComponent({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
        height: screenSize.height * 0.63,
        width: screenSize.width,
        child: Stack(
          children: [
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CircleAvatar(
                backgroundColor: AppColors.red,
                radius: 70,
              ),
            ),
            const Positioned(
              top: 0,
              bottom: 0,
              left: 30,
              child: CircleAvatar(
                backgroundColor: AppColors.purple,
                radius: 70,
              ),
            ),
            const Positioned(
              bottom: 0,
              right: 30,
              child: CircleAvatar(
                backgroundColor: AppColors.blueMain,
                radius: 50,
              ),
            ),
            Positioned.fill(
                top: 0,
                child: GlassMorphism(
                    child: Center(
                        child: SvgPicture.asset(
                  Assets.logo,
                  height: 100,
                  width: 100,
                )))),
          ],
        ));
  }
}
