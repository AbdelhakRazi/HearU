part of 'notes_bloc.dart';

sealed class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

final class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<Note> notes;
  const NotesLoaded(this.notes);

  @override
  List<Object> get props => [notes];
}

class NoteSaved extends NotesState {
  final Note note;
  const NoteSaved(this.note);

  @override
  List<Object> get props => [note];
}

class NotesError extends NotesState {
  final String message;
  const NotesError(this.message);

  @override
  List<Object> get props => [message];
}
