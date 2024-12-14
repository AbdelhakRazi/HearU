import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hearu/model/note.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorites';

  Future<void> saveFavorite(Note note) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    favorites.add(note.id!); // Ensure note id is non-null before adding
    await prefs.setString(_favoritesKey, json.encode(favorites));
  }

  Future<List<int>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesString = prefs.getString(_favoritesKey);
    if (favoritesString == null) {
      return [];
    }
    final List<int> favorites =
        (json.decode(favoritesString) as List).map((id) => id as int).toList();
    return favorites;
  }

  Future<void> removeFavorite(int noteId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    favorites.remove(noteId);
    await prefs.setString(_favoritesKey, json.encode(favorites));
  }
}
