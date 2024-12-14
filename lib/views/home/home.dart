import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hearu/bloc/auth_bloc.dart';
import 'package:hearu/bloc/notes_bloc.dart';
import 'package:hearu/config/assets.dart';
import 'package:hearu/config/colors.dart';
import 'package:hearu/services/notes/notes_service.dart';
import 'package:hearu/views/recording/recording.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int noteCount = 0; // Replace with your dynamic note count
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        print(state);
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

            // DraggableScrollableSheet
            DraggableScrollableSheet(
              expand: true, // Allow it to take its full height during scrolling
              initialChildSize: 0.1, // Start with 10% of the screen height
              minChildSize: 0.1, // Minimum size when collapsed
              maxChildSize: 0.95, // Maximum size when fully expanded
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      // Drag handle
                      SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              width: 60,
                              height: 5,
                              decoration: BoxDecoration(
                                color: AppColors.blueMain,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Header row
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "My Notes",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              BlocBuilder<NotesBloc, NotesState>(
                                builder: (context, state) {
                                  if (state is NotesLoaded) {
                                    noteCount = state.notes.length;
                                  }
                                  return Text(
                                    "$noteCount notes",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Sliver list of notes
                      BlocBuilder<NotesBloc, NotesState>(
                        builder: (context, state) {
                          if (state is NotesLoaded) {
                            return SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return ListTile(
                                    leading: const Icon(Icons.note),
                                    title: Text(state.notes[index].title),
                                    subtitle: Text(
                                      state.notes[index].content,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    onTap: () {
                                      // Handle note tap
                                    },
                                  );
                                },
                                childCount: state.notes.length,
                              ),
                            );
                          } else if (state is NotesLoading) {
                            return const SliverToBoxAdapter(
                                child:
                                    Center(child: CircularProgressIndicator()));
                          } else {
                            return const SliverToBoxAdapter(child: SizedBox());
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
