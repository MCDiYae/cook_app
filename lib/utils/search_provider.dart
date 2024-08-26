import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecipeProviderSearch extends ChangeNotifier {
  List<dynamic> _allRecipes = [];
  List<dynamic> _filteredRecipes = [];
  String _searchQuery = '';

  List<dynamic> get filteredRecipes => _filteredRecipes;
  String get searchQuery => _searchQuery;

  Future<void> loadRecipes() async {
    final String response =
        await rootBundle.loadString('assets/data/recipes.json');
    _allRecipes = json.decode(response);
    _updateFilteredRecipes();
    notifyListeners();
  }

  void filterRecipes(String query) {
    _searchQuery = query;
    _updateFilteredRecipes();
    notifyListeners();
  }

  void _updateFilteredRecipes() {
    if (_searchQuery.isNotEmpty) {
      // Show all recipes that match the query
      _filteredRecipes = _allRecipes
          .where((recipe) =>
              recipe['title']
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              (recipe['categories'] as List<dynamic>).any((category) => category
                  .toString()
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase())))
          .toList();
    } else {
      // Show only trending recipes when there's no query
      _filteredRecipes = _allRecipes
          .where((recipe) =>
              (recipe['categories'] as List<dynamic>).contains('trend'))
          .toList();
    }
  }

  List<dynamic> getTrendingRecipes() {
    return _allRecipes
        .where((recipe) =>
            (recipe['categories'] as List<dynamic>).contains('trend'))
        .toList();
  }

  List<dynamic> getAllRecipes() {
    return _allRecipes;
  }
}
