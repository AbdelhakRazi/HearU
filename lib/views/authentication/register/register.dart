// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearu/bloc/auth_bloc.dart';

import 'package:hearu/utils/input_validation.dart';
import 'package:hearu/views/authentication/components/auth_input.dart';
import 'package:hearu/views/authentication/components/auth_layout.dart';
import 'package:hearu/views/folders/folders.dart';
import 'package:hearu/views/home/home.dart';

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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late InputValidation inputValidation;
  @override
  void initState() {
    super.initState();
    inputValidation = InputValidation(passwordController: passwordController);
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
                MaterialPageRoute(builder: (context) => const Home()),
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
              label: "Enter your password",
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
