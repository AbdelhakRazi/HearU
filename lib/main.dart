import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearu/config/injection_locator.dart';
import 'package:hearu/config/theme.dart';
import 'package:hearu/state/onboarding_animation/onboarding_animation_bloc.dart';
import 'package:hearu/views/landing/landing.dart';
import 'package:hearu/views/onboarding/onboarding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingAnimationBloc(opacities: [1, 0, 0, 0]),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: const OnBoarding()),
    );
  }
}
