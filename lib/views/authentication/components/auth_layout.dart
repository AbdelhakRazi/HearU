import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hearu/bloc/auth_bloc.dart';

import 'package:hearu/config/assets.dart';
import 'package:hearu/views/authentication/components/auth_body.dart';
import 'package:hearu/views/authentication/components/auth_input.dart';
import 'package:hearu/views/authentication/login/login.dart';
import 'package:hearu/views/authentication/register/register.dart';
import 'package:hearu/views/components/glassmorphic_background.dart';

class AuthLayout extends StatelessWidget {
  final String title;
  final List<AuthInput> authInputs;
  final bool isLogin;
  final bool showBackButton; // New property
  final Color? backButtonColor; // Optional customizable color

  const AuthLayout({
    super.key,
    required this.title,
    required this.authInputs,
    required this.isLogin,
    this.showBackButton = false, // Default to false
    this.backButtonColor, // Defaults to theme's primary color
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Header with logo
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
              ),
            ),
          ),

          // Main content with inputs and buttons
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: screenSize.height * 0.75,
              width: screenSize.width,
              child: AuthBody(
                title: title,
                isAccountTitle: isLogin
                    ? "Don't have an account?"
                    : "Already have an account?",
                isAccountSubtitle: isLogin ? " Register" : " Login",
                onTap: () {
                  if (isLogin) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Register(
                                showBackButton: true,
                              )),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Login(
                                showBackButton: true,
                              )),
                    );
                  }
                },
                authInputs: authInputs,
              ),
            ),
          ),

          // Conditionally show the back button
          if (showBackButton)
            Positioned(
              top: 40, // Adjust for padding if needed
              left: 16,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: backButtonColor ?? Theme.of(context).primaryColor,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
        ],
      ),
    );
  }
}
