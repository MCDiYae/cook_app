import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoritesProvider with ChangeNotifier {
  final Box _favoritesBox = Hive.box('favorites');

  /// Check if a recipe is marked as favorite
  bool isFavorite(String recipeId) {
    return _favoritesBox.containsKey(recipeId);
  }

  /// Toggle the favorite status of a recipe
  void toggleFavoriteStatus(String recipeId) {
    if (isFavorite(recipeId)) {
      _favoritesBox.delete(recipeId);
    } else {
      _favoritesBox.put(recipeId, true);
    }
    notifyListeners();
  }

  /// Get all favorite recipe IDs
  List<String> get favoriteRecipeIds {
    return _favoritesBox.keys.cast<String>().toList();
  }
}
