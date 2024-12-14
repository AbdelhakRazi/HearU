// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:hearu/model/note.dart';
import 'package:hearu/services/notes/favorites_service.dart';

class NotesService {
  final String baseUrl;
  FavoritesService favoritesService;
  NotesService(
    this.baseUrl,
    this.favoritesService,
  );

  Future<List<Note>> fetchNotes(String authToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/notes'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> notesJson = json.decode(response.body);
      final allNotes = notesJson.map((json) => Note.fromJson(json)).toList();

      final favoriteIds = await favoritesService.getFavorites();
      final notesWithFavorites = allNotes.map((note) {
        final isFavorite = favoriteIds.contains(note.id);
        return note.copyWith(isFavorite: isFavorite);
      }).toList();

      return notesWithFavorites;
    } else {
      throw Exception('Failed to fetch notes');
    }
  }

  Future<Note> saveNote(Note note, String authToken) async {
    final response = await http.post(
      Uri.parse('$baseUrl/notes'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: json.encode(note.toJson()),
    );
    if (response.statusCode == 201) {
      return Note.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to save note');
    }
  }

  Future<void> deleteNote(int noteId, String authToken) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/notes/$noteId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );
    if (response.statusCode != 204) {
      throw Exception('Failed to delete note');
    }
    // If successfully deleted from the server, also remove it from favorites locally
    await favoritesService.removeFavorite(noteId);
  }
}
