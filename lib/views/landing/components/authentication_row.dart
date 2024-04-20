// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/action_button.dart';
import 'sso_button.dart';

class AuthenticationRow extends StatelessWidget {
  final String title;
  GlobalKey<FormState>? formKey;
  AuthenticationRow({
    super.key,
    required this.title,
    this.formKey,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SSOButton(icon: FontAwesomeIcons.apple, onPressed: () {}),
        SSOButton(icon: FontAwesomeIcons.google, onPressed: () {}),
        const Spacer(),
        Expanded(
            flex: 2,
            child: ActionButton.withIcon(
              onPressed: () {
                if (formKey != null) {
                  formKey!.currentState!.validate();
                }
              },
              trailingIcon: FontAwesomeIcons.arrowRightLong,
              text: title,
            )),
      ],
    );
  }
}
