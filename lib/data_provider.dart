import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/recipe.dart';
import 'models/category.dart';

class RecipeProvider with ChangeNotifier {
  List<Recipe> _recipes = [];
  List<Category> _categories = [];
  List<Recipe> get recipes => _recipes;
  List<Category> get categories => _categories;

  Future<void> loadCategories() async {
    final String response = await rootBundle.loadString('assets/categories.json');
    final data = await json.decode(response) as List;
    _categories = data.map((json) => Category.fromJson(json)).toList();
    notifyListeners();
  }

  Future<void> loadRecipes() async {
    await loadCategories(); // Load categories first
    final String response = await rootBundle.loadString('assets/recipes.json');
    final data = await json.decode(response) as List;
    _recipes = data.map((json) => Recipe.fromJson(json, _categories)).toList();
    notifyListeners();
  }
}
