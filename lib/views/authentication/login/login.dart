import 'package:flutter/material.dart';
import 'package:hearu/views/authentication/components/auth_layout.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthLayout(title: "Sign in");
  }
}
