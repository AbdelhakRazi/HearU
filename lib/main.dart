import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearu/bloc/auth_bloc.dart';
import 'package:hearu/services/authentication/spring_auth_service.dart';
import 'package:hearu/views/authentication/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:hearu/config/injection_locator.dart';
import 'package:hearu/config/theme.dart';
import 'package:hearu/state/onboarding_animation/onboarding_animation_bloc.dart';
import 'package:hearu/views/landing/landing.dart';
import 'package:hearu/views/onboarding/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();

  // Ensure SharedPreferences is initialized
  final prefs = await SharedPreferences.getInstance();
  final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  // Set the first launch flag to false if it's the first time
  if (isFirstLaunch) {
    await prefs.setBool('isFirstLaunch', false);
  }

  runApp(MyApp(isFirstLaunch: isFirstLaunch));
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  const MyApp({super.key, required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnboardingAnimationBloc(opacities: [1, 0, 0, 0]),
        ),
        BlocProvider(create: (context) => AuthBloc(SpringAuthService()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        // Show Onboarding or Landing based on isFirstLaunch
        home: isFirstLaunch ? const OnBoarding() : const Login(),
      ),
    );
  }
}
