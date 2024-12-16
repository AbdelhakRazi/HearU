import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hearu/bloc/notes_bloc.dart';
import 'package:hearu/config/colors.dart';
import 'package:hearu/views/notes/note_card.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  int noteCount = 0;
  String searchQuery = "";
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 0.15,
      minChildSize: 0.15,
      maxChildSize: 0.7,
      builder: (BuildContext context, ScrollController scrollController) {
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
              // Header row with search
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "My Notes",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          BlocBuilder<NotesBloc, NotesState>(
                            builder: (context, state) {
                              print(state);
                              if (state is NotesLoaded) {
                                noteCount = state.notes.length;
                              }
                              return Text(
                                "$noteCount ${noteCount == 1 ? 'note' : 'notes'}",
                                style: Theme.of(context).textTheme.bodyMedium,
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Search notes...",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: AppColors.blueMain),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Sliver list of notes
              BlocBuilder<NotesBloc, NotesState>(
                builder: (context, state) {
                  if (state is NotesLoaded) {
                    final filteredNotes = state.notes.where((note) {
                      return note.title
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase());
                    }).toList();

                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return NoteCard(note: filteredNotes[index]);
                        },
                        childCount: filteredNotes.length,
                      ),
                    );
                  } else if (state is NotesLoading) {
                    return const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()));
                  } else {
                    return const SliverToBoxAdapter(child: SizedBox());
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
