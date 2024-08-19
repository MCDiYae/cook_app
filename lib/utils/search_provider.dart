import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecipeProviders extends ChangeNotifier {
  List<dynamic> _allRecipes = [];
  List<dynamic> _filteredRecipes = [];
  String _searchQuery = '';

  List<dynamic> get filteredRecipes => _filteredRecipes;
  String get searchQuery => _searchQuery;

  Future<void> loadRecipes() async {
    final String response =
        await rootBundle.loadString('assets/data/recipes.json');
    _allRecipes = json.decode(response);
    _filteredRecipes = _allRecipes;
    notifyListeners();
  }

  void filterRecipes(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredRecipes = _allRecipes;
    } else {
      _filteredRecipes = _allRecipes
          .where((recipe) =>
              recipe['title'].toLowerCase().contains(query.toLowerCase()) ||
              (recipe['categories'] as List<dynamic>).any((category) => category
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase())))
          .toList();
    }
    notifyListeners();
  }
}
