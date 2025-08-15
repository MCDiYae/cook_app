import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/recipe.dart';
import '../../../data/repositories/recipe_repository.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final Connectivity connectivity = Connectivity();
  final RecipeRepository repository;

  RecipeBloc(this.repository) : super(RecipeInitial()) {
    on<FetchTrendingRecipes>(_onFetchTrendingRecipes);
    on<SearchRecipes>(_onSearchRecipes);
    on<FetchRecipes>(_onFetchRecipes);
    on<FetchRecipesByCategory>(_onFetchRecipesByCategory);
  }

  Future<void> _onFetchTrendingRecipes(
      FetchTrendingRecipes event, Emitter<RecipeState> emit) async {
    emit(RecipeLoading());
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        emit(RecipeNoInternet());
      } else {
        final recipes = await repository.getRecipes();
        final trendRecipes = recipes.where((recipe) {
          return recipe.categories.contains("trend");
        }).toList();
        emit(RecipeLoaded(trendRecipes));
      }
    } catch (e) {
      emit(RecipeError("Failed to fetch trending recipes"));
    }
  }

  Future<void> _onSearchRecipes(
      SearchRecipes event, Emitter<RecipeState> emit) async {
    emit(RecipeLoading());
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        emit(RecipeNoInternet());
      } else {
        final recipes = await repository.getRecipes();

        // Search through all recipes
        final searchResults = recipes.where((recipe) {
          return recipe.title.toLowerCase().contains(event.query.toLowerCase());
        }).toList();

        emit(RecipeLoaded(searchResults));
      }
    } catch (e) {
      emit(RecipeError("Failed to search recipes"));
    }
  }

  Future<void> _onFetchRecipes(
      FetchRecipes event, Emitter<RecipeState> emit) async {
    emit(RecipeLoading());
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        emit(RecipeNoInternet());
      } else {
        final recipes = await repository.getRecipes();
        emit(RecipeLoaded(recipes));
      }
    } catch (e) {
      emit(RecipeError("failed to fetch recipes"));
    }
  }

Future<void> _onFetchRecipesByCategory(
      FetchRecipesByCategory event, Emitter<RecipeState> emit) async {
    emit(RecipeLoading());
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        emit(RecipeNoInternet());
      } else {
        final recipes = await repository.getRecipes();
        final categorizedRecipes = recipes.where((recipe) {
          return recipe.categories.contains(event.category);
        }).toList();
        emit(RecipesByCategoryLoaded(categorizedRecipes));
      }
    } catch (e) {
      emit(RecipeError("Failed to fetch recipes by category"));
    }
  }

}
