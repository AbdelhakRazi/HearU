// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hearu/bloc/auth_bloc.dart';

import 'package:hearu/utils/input_validation.dart';
import 'package:hearu/views/authentication/components/auth_input.dart';
import 'package:hearu/views/authentication/components/auth_layout.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearu/views/home/home.dart';

class Login extends StatefulWidget {
  final bool showBackButton;

  const Login({Key? key, this.showBackButton = false}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } // else if (state is AuthSuccess) {
        //   Navigator.pushAndRemoveUntil(
        //       context,
        //       MaterialPageRoute(builder: (context) => const Home()),
        //       (route) => false);
        // }
      },
      child: AuthLayout(
        showBackButton: widget.showBackButton,
        isLogin: true,
        title: "Sign In",
        authInputs: [
          AuthInput(
            hintText: "email@example.com",
            label: "Enter your email",
            textEditingController: emailController,
            validation: InputValidation().validateEmail,
          ),
          AuthInput(
            hintText: "*****",
            label: "Enter your password",
            obscured: true,
            textEditingController: passwordController,
            validation: InputValidation().validatePassword,
          ),
        ],
      ),
    );
  }
}
