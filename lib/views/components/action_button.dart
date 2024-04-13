// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData? trailingIcon;
  final String text;
  const ActionButton.withIcon({
    super.key,
    required this.onPressed,
    required this.trailingIcon,
    required this.text,
  });
  const ActionButton({
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
              ),
              onPressed: onPressed,
              label: Text(text),
            ),
          ),
        ),
      ],
    );
  }
}
