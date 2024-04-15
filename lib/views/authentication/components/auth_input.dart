// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hearu/config/measures.dart';

class AuthInput extends StatefulWidget {
  final String hintText;
  final String label;
  const AuthInput({
    super.key,
    required this.hintText,
    required this.label,
  });

  @override
  State<AuthInput> createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.labelLarge),
        Padding(
          padding:
              const EdgeInsets.symmetric(vertical: Measures.topBottomPadding),
          child: TextFormField(
            decoration: InputDecoration(hintText: widget.hintText),
          ),
        )
      ],
    );
  }
}
