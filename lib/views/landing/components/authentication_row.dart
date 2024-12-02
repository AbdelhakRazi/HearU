// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hearu/views/authentication/login/login.dart';

import '../../components/action_button.dart';
import 'sso_button.dart';

class AuthenticationRow extends StatelessWidget {
  final String title;
  GlobalKey<FormState>? formKey;
  VoidCallback onPressed;
  AuthenticationRow(
      {super.key, required this.title, this.formKey, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SSOButton(icon: FontAwesomeIcons.apple, onPressed: () {}),
          SSOButton(icon: FontAwesomeIcons.google, onPressed: () {}),
          const Spacer(),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.1,
              child: ActionButton.withIcon(
                onPressed: onPressed,
                trailingIcon: FontAwesomeIcons.arrowRightLong,
                text: title,
              )),
        ],
      ),
    );
  }
}
