// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:hearu/config/assets.dart';
import 'package:hearu/views/authentication/components/auth_body.dart';
import 'package:hearu/views/authentication/components/auth_input.dart';
import 'package:hearu/views/components/glassmorphic_background.dart';

class AuthLayout extends StatelessWidget {
  final String title;
  final List<AuthInput> authInputs;
  const AuthLayout({
    super.key,
    required this.title,
    required this.authInputs,
  });
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            top: 0,
            child: SizedBox(
                height: screenSize.height * 0.3,
                width: screenSize.width,
                child: GlassmorphicBackground(
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.logo,
                      height: 70,
                      width: 70,
                    ),
                  ),
                ))),
        Positioned(
            bottom: 0,
            child: SizedBox(
                height: screenSize.height * 0.75,
                width: screenSize.width,
                child: AuthBody(
                  title: title,
                  authInputs: authInputs,
                )))
      ],
    ));
  }
}
