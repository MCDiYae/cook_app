import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/recipe.dart';

part 'favorite_state.dart';

class FavoritesCubit extends Cubit<List<Recipe>> {
  FavoritesCubit() : super([]);

  void loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString('favorites');
    if (favoritesJson != null) {
      final List<dynamic> favoritesList = json.decode(favoritesJson);
      emit(favoritesList.map((json) => Recipe.fromJson(json)).toList());
    }
  }

  void addFavorite(Recipe recipe) async {
    final currentFavorites = List<Recipe>.from(state);
    if (!currentFavorites.any((r) => r.id == recipe.id)) {
      currentFavorites.add(recipe);
      emit(currentFavorites);
      _saveFavorites(currentFavorites);
    }
  }

  void removeFavorite(String recipeId) async {
    final currentFavorites = List<Recipe>.from(state);
    currentFavorites.removeWhere((recipe) => recipe.id == recipeId);
    emit(currentFavorites);
    _saveFavorites(currentFavorites);
  }

  void _saveFavorites(List<Recipe> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final String favoritesJson = json.encode(favorites
        .map((recipe) => {
              'id': recipe.id,
              'title': recipe.title,
              'imageUrl': recipe.imageUrl,
              'categories': recipe.categories,
              'ingredients': recipe.ingredients,
              'steps': recipe.steps,
            })
        .toList());
    prefs.setString('favorites', favoritesJson);
  }
}
