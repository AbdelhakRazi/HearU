import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearu/config/injection_locator.dart';
import 'package:hearu/config/theme.dart';
import 'package:hearu/model/folder.dart';
import 'package:hearu/services/transcribe-client/transcribe.dart';
import 'package:hearu/state/onboarding_animation/onboarding_animation_bloc.dart';
import 'package:hearu/views/authentication/login/login.dart';
import 'package:hearu/views/authentication/register/register.dart';
import 'package:hearu/views/folders/folders.dart';
import 'package:hearu/views/landing/landing.dart';
import 'package:hearu/views/onboarding/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  Transcribe transcribe = Transcribe();
  await transcribe.transcribe();
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
          home: const Folders()),
    );
  }
}
