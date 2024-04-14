// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:hearu/config/colors.dart';
import 'package:hearu/views/components/glassmorphism_container.dart';


class GlassmorphicBackground extends StatelessWidget {
  final Widget child;
  const GlassmorphicBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                child: child)),
      ],
    );
  }
}
