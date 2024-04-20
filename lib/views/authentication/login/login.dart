import 'package:flutter/material.dart';
import 'package:hearu/utils/input_validation.dart';
import 'package:hearu/views/authentication/components/auth_input.dart';
import 'package:hearu/views/authentication/components/auth_layout.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late InputValidation inputValidation;
  @override
  void initState() {
    super.initState();
    inputValidation = InputValidation();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: "Sign in",
      authInputs: [
        AuthInput(
          hintText: "email@example.com",
          label: "Enter your email",
          validation: inputValidation.validateEmail,
        ),
        AuthInput(
          hintText: "*****",
          label: "Enter you password",
          obscured: true,
          validation: inputValidation.validatePassword,
        ),
      ],
    );
  }
}
