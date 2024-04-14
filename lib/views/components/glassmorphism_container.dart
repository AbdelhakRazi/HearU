import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hearu/config/colors.dart';

class GlassMorphism extends StatelessWidget {
  final Widget child;
  const GlassMorphism({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 60,
        sigmaY: 60,
      ),
      child: Container(color: AppColors.purple.withOpacity(0.05), child: child),
    );
  }
}
