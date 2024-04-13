import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/action_button.dart';
import 'sso_button.dart';

class AuthenticationRow extends StatelessWidget {
  const AuthenticationRow({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SSOButton(icon: FontAwesomeIcons.apple, onPressed: () {}),
        SSOButton(icon: FontAwesomeIcons.google, onPressed: () {}),
        const Spacer(),
        Expanded(
            flex: 2,
            child: ActionButton.withIcon(
              onPressed: () {},
              trailingIcon: FontAwesomeIcons.arrowRightLong,
              text: 'Sign in',
            )),
      ],
    );
  }
}
