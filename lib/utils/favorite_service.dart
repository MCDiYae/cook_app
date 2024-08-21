import 'dart:convert';
import 'package:cook_app/models/recipe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;

class FavoriteRecipeService {
  static const String _favoriteRecipesKey = 'favoriteRecipes';

  Future<List<Recipe>> loadFavoriteRecipes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoriteRecipeIds = prefs.getStringList(_favoriteRecipesKey) ?? [];
      final allRecipes = await _fetchAllRecipes();

      return allRecipes
          .where((recipe) => favoriteRecipeIds.contains(recipe.id))
          .toList();
    } catch (e) {
      // ignore: avoid_print
      print('Error loading favorite recipes: $e');
      return [];
    }
  }

  Future<List<Recipe>> _fetchAllRecipes() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/recipes.json');
      final List<dynamic> data = json.decode(response);

      return data.map<Recipe>((json) => Recipe.fromJson(json)).toList();
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching all recipes: $e');
      return [];
    }
  }

  Future<bool> isFavorite(String recipeId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteRecipeIds = prefs.getStringList(_favoriteRecipesKey) ?? [];
    return favoriteRecipeIds.contains(recipeId);
  }

  Future<bool> toggleFavorite(String recipeId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteRecipeIds = prefs.getStringList(_favoriteRecipesKey) ?? [];

    if (favoriteRecipeIds.contains(recipeId)) {
      favoriteRecipeIds.remove(recipeId);
    } else {
      favoriteRecipeIds.add(recipeId);
    }

    await prefs.setStringList(_favoriteRecipesKey, favoriteRecipeIds);
    return favoriteRecipeIds.contains(recipeId);
  }

  Future<void> removeFromFavorites(String recipeId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteRecipeIds = prefs.getStringList(_favoriteRecipesKey) ?? [];
    favoriteRecipeIds.remove(recipeId);
    await prefs.setStringList(_favoriteRecipesKey, favoriteRecipeIds);
  }
}
