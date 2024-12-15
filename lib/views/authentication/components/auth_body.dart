import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearu/bloc/auth_bloc.dart';
import 'package:hearu/config/colors.dart';
import 'package:hearu/views/authentication/components/auth_input.dart';

class AuthBody extends StatefulWidget {
  final String title;
  final String isAccountTitle;
  final String isAccountSubtitle;
  final List<AuthInput> authInputs;
  final VoidCallback onTap;

  const AuthBody({
    super.key,
    required this.title,
    required this.isAccountTitle,
    required this.isAccountSubtitle,
    required this.authInputs,
    required this.onTap,
  });

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Collect TextEditingController instances
  Map<String, TextEditingController> _collectControllers() {
    final controllers = <String, TextEditingController>{};
    for (var input in widget.authInputs) {
      if (input.textEditingController != null) {
        print(input.label);
        controllers[input.label] = input.textEditingController!;
      }
    }
    return controllers;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * 0.75,
      width: screenSize.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, -5),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          Form(
            key: formKey,
            child: Column(
              children: widget.authInputs,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final controllers = _collectControllers();

                    // Trigger Bloc events based on title
                    if (widget.title == "Sign In") {
                      BlocProvider.of<AuthBloc>(context).add(
                        LoginEvent(
                          email: controllers["Enter your email"]!.text,
                          password: controllers["Enter your password"]!.text,
                        ),
                      );
                    } else if (widget.title == "Create an account") {
                      BlocProvider.of<AuthBloc>(context).add(
                        RegisterEvent(
                          email: controllers["Enter your email"]!.text,
                          password: controllers["Enter your password"]!.text,
                        ),
                      );
                    }
                  }
                },
                child: Text(widget.title == "Create an account"
                    ? "SIGN UP"
                    : "Sign In"),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // const Row(
          //   children: [
          //     Expanded(child: Divider()),
          //     SizedBox(width: 10),
          //     Text(
          //       "Or",
          //     ), // Optional: adjust text style as needed
          //     SizedBox(width: 10),
          //     Expanded(child: Divider()),
          //   ],
          // ),

          GestureDetector(
            onTap: widget.onTap,
            child: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.isAccountTitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: widget.isAccountSubtitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
