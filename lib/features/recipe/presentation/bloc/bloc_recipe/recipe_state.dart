part of 'recipe_bloc.dart';

abstract class RecipeState {}

class RecipeInitial extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeLoaded extends RecipeState {
  final List<Recipe> recipes;

  RecipeLoaded(this.recipes);
}
class RecipesByCategoryLoaded extends RecipeState {
  final List<Recipe> categorizedRecipes;

  RecipesByCategoryLoaded(this.categorizedRecipes);
}
class RecipeError extends RecipeState {
  final String message;

  RecipeError(this.message);
}

class RecipeNoInternet extends RecipeState {}