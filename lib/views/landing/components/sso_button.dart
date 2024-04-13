// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hearu/config/colors.dart';
import 'package:hearu/config/measures.dart';

class SSOButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const SSOButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(Measures.smallPadding),
          backgroundColor: AppColors.lightGrey,
          elevation: 0),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: AppColors.dark,
      ),
    );
  }
}
