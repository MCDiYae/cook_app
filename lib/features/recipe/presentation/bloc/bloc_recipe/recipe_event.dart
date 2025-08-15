part of 'recipe_bloc.dart';

abstract class RecipeEvent {}

class FetchTrendingRecipes extends RecipeEvent {}

class SearchRecipes extends RecipeEvent {
  final String query;

  SearchRecipes(this.query);
}
class FetchRecipes extends RecipeEvent {}
class FetchRecipesByCategory extends RecipeEvent {
  final String category;

  FetchRecipesByCategory(this.category);
}