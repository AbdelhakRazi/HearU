// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:hearu/bloc/auth_bloc.dart';
import 'package:hearu/bloc/notes_bloc.dart';
import 'package:hearu/config/assets.dart';
import 'package:hearu/config/colors.dart';
import 'package:hearu/views/notes/note_card.dart';
import 'package:hearu/views/notes/notes.dart';
import 'package:hearu/views/recording/recording.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          BlocProvider.of<NotesBloc>(context).add(FetchNotesEvent(
              authToken: BlocProvider.of<AuthBloc>(context).authToken!));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: SvgPicture.asset(
            Assets.logo,
            height: 54,
            width: 54,
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  size: 34,
                ))
          ],
        ),
        body: Stack(
          children: [
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Outer blurred border
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.5,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: -20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 10,
                                color: AppColors.blueMain.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Inner solid circle with icon
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Recording()),
                          );
                        },
                        icon: const Icon(
                          Icons.mic_sharp,
                          size: 54,
                          color: AppColors.blueMain,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Tap to record a note",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),

            const Notes()
          ],
        ),
      ),
    );
  }
}
