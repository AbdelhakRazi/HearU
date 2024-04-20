// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:hearu/config/colors.dart';
import 'package:hearu/config/measures.dart';
import 'package:hearu/config/spacing_widgets.dart';
import 'package:hearu/views/authentication/components/auth_input.dart';
import 'package:hearu/views/landing/components/authentication_row.dart';

class AuthBody extends StatefulWidget {
  final String title;
  final List<AuthInput> authInputs;
  const AuthBody({
    Key? key,
    required this.title,
    required this.authInputs,
  }) : super(key: key);

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
          const Spacer(),
          Expanded(
              flex: 2,
              child: AuthenticationRow(
                title: widget.title,
                formKey: formKey,
              )),
          const Spacer(),
        ],
      ),
    );
  }
}
