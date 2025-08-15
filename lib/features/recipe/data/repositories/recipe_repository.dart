import 'package:cook_app/features/recipe/data/datasources/remote_data.dart';

import '../models/recipe.dart';

class RecipeRepository {
  final RecipeRemoteDataSource remoteDataSource;
  final List<Recipe> _allRecipes = [];
  RecipeRepository(this.remoteDataSource);

  Future<List<Recipe>> getRecipes() async {
    if (_allRecipes.isEmpty) {
      return await remoteDataSource.fetchRecipes();
    }
    return _allRecipes;
  }

  Future<List<Recipe>> getTrendingRecipes() async {
    return await remoteDataSource.fetchTrendingRecipes();
  }
  Future<List<Recipe>> searchRecipes(String query) async {
    if (_allRecipes.isEmpty) {
      await getRecipes();
    }
    return _allRecipes
        .where((recipe) =>
            recipe.title.toLowerCase().contains(query.toLowerCase()) ||
            recipe.ingredients.any((ingredient) =>
                ingredient.toLowerCase().contains(query.toLowerCase())))
        .toList();
  }
}
