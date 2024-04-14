// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hearu/config/colors.dart';
import 'package:hearu/views/components/action_button.dart';

class ActionOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData? trailingIcon;
  final String text;
  const ActionOutlinedButton.withIcon({
    super.key,
    required this.onPressed,
    required this.trailingIcon,
    required this.text,
  });
  const ActionOutlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
  }) : trailingIcon = null;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          left: 2,
          right: 2,
          top: 4,
          child: OutlinedButton(
            onPressed: null,
            child: null,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ElevatedButton.icon(
              icon: Icon(
                trailingIcon,
                size: 16,
                color: AppColors.dark,
              ),
              onPressed: onPressed,
              label: Text(
                text,
                style: const TextStyle(color: AppColors.dark),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  side: const BorderSide(color: AppColors.dark, width: 1.5)),
            ),
          ),
        ),
      ],
    );
  }
}
