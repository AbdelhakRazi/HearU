import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hearu/bloc/auth_bloc.dart';
import 'package:hearu/bloc/notes_bloc.dart';
import 'package:hearu/config/colors.dart';
import 'package:hearu/model/note.dart';
import 'package:hearu/services/notes/favorites_service.dart';

class NoteCard extends StatefulWidget {
  final Note note;
  const NoteCard({
    super.key,
    required this.note,
  });

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (context) => _confirmDelete(context, widget.note),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.red,
            icon: Icons.delete,
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppColors.blueMain.withOpacity(0.05),
            borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          tileColor: AppColors.dark,
          trailing: IconButton(
            onPressed: () async {
              setState(() {
                widget.note.isFavorite = !widget.note.isFavorite;
              });
              await FavoritesService().saveFavorite(widget.note);
            }, // Add favorite logic here if needed
            icon: Icon(
              widget.note.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border_rounded,
              color: widget.note.isFavorite
                  ? AppColors.blueMain
                  : AppColors.blueMain,
            ),
          ),
          title: Text(
            widget.note.title,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColors.dark),
          ),
          subtitle: Text(
            widget.note.content,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            // Handle note tap
          },
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Cancel deletion
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<NotesBloc>(context).add(
                DeleteNoteEvent(
                    noteId: note.id!,
                    authToken: BlocProvider.of<AuthBloc>(context).authToken!),
              );
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
