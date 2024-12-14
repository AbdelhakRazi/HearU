import 'dart:convert';
import 'package:hearu/model/note.dart';
import 'package:http/http.dart' as http;

class NotesService {
  final String baseUrl;

  NotesService(this.baseUrl);

  Future<List<Note>> fetchNotes(String authToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/notes'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );
    print(response.statusCode);
    print(response.request);
    if (response.statusCode == 200) {
      final List<dynamic> notesJson = json.decode(response.body);
      print(notesJson);
      return notesJson.map((json) => Note.fromJson(json)).toList();
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
}
