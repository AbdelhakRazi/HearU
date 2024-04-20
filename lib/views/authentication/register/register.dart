import 'package:flutter/material.dart';
import 'package:hearu/utils/input_validation.dart';
import 'package:hearu/views/authentication/components/auth_input.dart';
import 'package:hearu/views/authentication/components/auth_layout.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController passwordController;
  late InputValidation inputValidation;
  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    inputValidation = InputValidation(passwordController: passwordController);
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
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
    );
  }
}
