import 'package:cook_app/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoritesProvider with ChangeNotifier {
  final Box _favoritesBox = Hive.box('favorites');

  /// Check if a recipe is marked as favorite
  bool isFavorite(String recipeId) {
    return _favoritesBox.containsKey(recipeId);
  }

  /// Toggle the favorite status of a recipe
  void toggleFavoriteStatut(String recipeId) {
    if (isFavorite(recipeId)) {
      _favoritesBox.delete(recipeId);
    } else {
      _favoritesBox.put(recipeId, true);
    }
    notifyListeners();
  }

  void toggleFavoriteStatus(Recipe recipe) {
       if (isFavorite(recipe.id)) {
         _favoritesBox.delete(recipe.id);
       } else {
         _favoritesBox.put(recipe.id, recipe);
       }
       notifyListeners();
     }

  /// Get all favorite recipe IDs
  List<String> get favoriteRecipeIds {
    return _favoritesBox.keys.cast<String>().toList();
  }
  List<Recipe> get favoriteRecipes {
    return _favoritesBox.values.cast<Recipe>().toList();
  }
}
