import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hearu/model/note.dart';
import 'package:hearu/services/notes/notes_service.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesService notesService;

  NotesBloc(this.notesService) : super(NotesInitial()) {
    on<FetchNotesEvent>(_onFetchNotes);
    on<SaveNoteEvent>(_onSaveNote);
    on<DeleteNoteEvent>(_onDeleteNote);
  }

  Future<void> _onFetchNotes(
      FetchNotesEvent event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      final notes = await notesService.fetchNotes(event.authToken);
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(const NotesError('Failed to fetch notes'));
    }
  }

  Future<void> _onSaveNote(
      SaveNoteEvent event, Emitter<NotesState> emit) async {
    try {
      final note = await notesService.saveNote(event.note, event.authToken);
      emit(NoteSaved(note));
      add(FetchNotesEvent(authToken: event.authToken)); // Refresh the list
    } catch (e) {
      emit(const NotesError('Failed to save note'));
    }
  }

  Future<void> _onDeleteNote(
      DeleteNoteEvent event, Emitter<NotesState> emit) async {
    try {
      await notesService.deleteNote(event.noteId, event.authToken);
      // Refresh the notes list after deletion
      add(FetchNotesEvent(authToken: event.authToken));
    } catch (e) {
      emit(const NotesError('Failed to delete note'));
    }
  }
}
