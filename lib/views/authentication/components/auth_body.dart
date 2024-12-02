// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:hearu/config/colors.dart';
import 'package:hearu/config/measures.dart';
import 'package:hearu/config/spacing_widgets.dart';
import 'package:hearu/views/authentication/components/auth_input.dart';
import 'package:hearu/views/landing/components/authentication_row.dart';

class AuthBody extends StatefulWidget {
  final String title;
  final String isAccountTitle;
  final String isAccountSubtitle;
  final List<AuthInput> authInputs;
  final VoidCallback onTap;
  const AuthBody({
    super.key,
    required this.title,
    required this.isAccountTitle,
    required this.isAccountSubtitle,
    required this.authInputs,
    required this.onTap,
  });

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Measures.basicRadius),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
                color: AppColors.dark.withOpacity(0.1),
                offset: const Offset(0, -5),
                blurRadius: 20,
                spreadRadius: 50)
          ]),
      padding: const EdgeInsets.symmetric(
          horizontal: Measures.leftRightPadding,
          vertical: Measures.topBottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SpacingWidgets.emptyHeight,
          Form(
              key: formKey,
              child: Column(
                  children: List.generate(widget.authInputs.length,
                      (index) => widget.authInputs[index]))),
          SpacingWidgets.emptyHeight,
          SpacingWidgets.emptyHeight,
          SpacingWidgets.emptyHeight,
          AuthenticationRow(
            title: widget.title,
            formKey: formKey,
            onPressed: () {
              formKey.currentState!.validate();
            },
          ),
          GestureDetector(
            onTap: widget.onTap,
            child: Center(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: widget.isAccountTitle,
                    style: Theme.of(context).textTheme.bodyMedium),
                TextSpan(
                    text: widget.isAccountSubtitle,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline))
              ])),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
