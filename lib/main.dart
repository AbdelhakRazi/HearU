import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hearu/bloc/auth_bloc.dart';
import 'package:hearu/bloc/notes_bloc.dart';
import 'package:hearu/services/authentication/spring_auth_service.dart';
import 'package:hearu/services/notes/favorites_service.dart';
import 'package:hearu/services/notes/notes_service.dart';
import 'package:hearu/views/authentication/login/login.dart';
import 'package:hearu/views/folders/folders.dart';
import 'package:hearu/views/home/home.dart';
import 'package:hearu/views/recording/recording.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:hearu/config/injection_locator.dart';
import 'package:hearu/config/theme.dart';
import 'package:hearu/state/onboarding_animation/onboarding_animation_bloc.dart';
import 'package:hearu/views/landing/landing.dart';
import 'package:hearu/views/onboarding/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  final prefs = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();

  // Check for first launch
  final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
  // Set the first launch flag to false if it's the first time
  if (isFirstLaunch) {
    await prefs.setBool('isFirstLaunch', false);
  }
  // Retrieve token from secure storage
  final String? savedToken = await secureStorage.read(key: 'authToken');

  runApp(MyApp(
    isFirstLaunch: isFirstLaunch,
    initialToken: savedToken,
  ));
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;
  final String? initialToken;

  const MyApp({
    super.key,
    required this.isFirstLaunch,
    required this.initialToken,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final authBloc = AuthBloc(
              SpringAuthService(
                  baseUrl: "https://hearu-latest.onrender.com/api/v1"),
            );
            // Initialize the AuthBloc with the token if it exists
            if (initialToken != null) {
              authBloc.add(InitializeAuthEvent(initialToken!));
            }
            return authBloc;
          },
        ),
        BlocProvider(
            create: (context) => NotesBloc(NotesService(
                "https://hearu-latest.onrender.com/api/v1",
                FavoritesService()))),
        BlocProvider(
          create: (context) => OnboardingAnimationBloc(opacities: [1, 0, 0, 0]),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: isFirstLaunch
            ? const OnBoarding()
            : (initialToken != null ? const Login() : const Landing()),
      ),
    );
  }
}
