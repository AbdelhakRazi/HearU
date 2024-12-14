part of 'notes_bloc.dart';

sealed class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class FetchNotesEvent extends NotesEvent {
  final String authToken;

  const FetchNotesEvent({required this.authToken});
}

class SaveNoteEvent extends NotesEvent {
  final Note note;
  final String authToken;
  const SaveNoteEvent(this.note, this.authToken);

  @override
  List<Object> get props => [note];
}

class DeleteNoteEvent extends NotesEvent {
  final int noteId;
  final String authToken;

  const DeleteNoteEvent({required this.noteId, required this.authToken});

  @override
  List<Object> get props => [noteId, authToken];
}
