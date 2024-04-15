import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hearu/config/assets.dart';
import 'package:hearu/views/authentication/components/auth_body.dart';
import 'package:hearu/views/authentication/components/auth_input.dart';
import 'package:hearu/views/components/glassmorphic_background.dart';

class AuthLayout extends StatelessWidget {
  final String title;
  const AuthLayout({super.key, required this.title});

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
                  authInputs: const [
                    AuthInput(
                      hintText: "username123",
                      label: "Enter your username",
                    ),
                    AuthInput(
                      hintText: "email@example.com",
                      label: "Enter your email",
                    ),
                    AuthInput(
                      hintText: "*****",
                      label: "Enter you password",
                    ),
                    AuthInput(
                      hintText: "*****",
                      label: "Confirm your password",
                    ),
                  ],
                )))
      ],
    ));
  }
}
