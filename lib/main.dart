import 'package:flutter/material.dart';
import 'package:hearu/config/injection_locator.dart';
import 'package:hearu/config/theme.dart';
import 'package:hearu/views/landing/landing.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const Landing());
  }
}
