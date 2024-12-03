// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearu/bloc/auth_bloc.dart';

import 'package:hearu/utils/input_validation.dart';
import 'package:hearu/views/authentication/components/auth_input.dart';
import 'package:hearu/views/authentication/components/auth_layout.dart';
import 'package:hearu/views/folders/folders.dart';

class Register extends StatefulWidget {
  final bool showBackButton; // New property

  const Register({
    Key? key,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController passwordController;
  late TextEditingController emailController;

  late InputValidation inputValidation;
  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    inputValidation = InputValidation(passwordController: passwordController);
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AuthSuccess) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Folders()),
                (route) => false);
          }
        },
        child: AuthLayout(
          showBackButton: widget.showBackButton,
          isLogin: false,
          title: "Register",
          authInputs: [
            AuthInput(
              hintText: "username123",
              label: "Enter your username",
              validation: inputValidation.validateUsername,
            ),
            AuthInput(
              hintText: "email@example.com",
              label: "Enter your email",
              textEditingController: emailController,
              validation: inputValidation.validateEmail,
            ),
            AuthInput(
              hintText: "*****",
              label: "Enter you password",
              obscured: true,
              textEditingController: passwordController,
              validation: inputValidation.validatePassword,
            ),
            AuthInput(
              hintText: "*****",
              label: "Confirm your password",
              obscured: true,
              validation: inputValidation.validateConfirmPassword,
            ),
          ],
        ));
  }
}
