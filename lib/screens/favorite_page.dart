import 'package:cook_app/utils/favorite_service.dart';
import 'package:cook_app/widgets/recipe_list.dart';
import 'package:flutter/material.dart';

import 'package:cook_app/models/recipe.dart';
import 'package:cook_app/screens/recipe_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late Future<List<Recipe>> _favoriteRecipesFuture;
  final FavoriteRecipeService _favoriteService = FavoriteRecipeService();

  @override
  void initState() {
    super.initState();
    _loadFavoriteRecipes();
  }

  void _loadFavoriteRecipes() {
    setState(() {
      _favoriteRecipesFuture = _favoriteService.loadFavoriteRecipes();
    });
  }

  Future<void> _removeFromFavorites(Recipe recipe) async {
    await _favoriteService.removeFromFavorites(recipe.id);
    _loadFavoriteRecipes(); // Reload the list after removing
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Recipes"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _favoriteRecipesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No favorite recipes'));
          } else {
            return _buildRecipeList(snapshot.data!);
          }
        },
      ),
    );
  }

  Widget _buildRecipeList(List<Recipe> recipes) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return RecipeListItem(
          recipe: recipe,
          onTap: () => _navigateToRecipePage(recipe),
          onRemove: () {
            _removeFromFavorites(recipe);
          },
        );
      },
    );
  }

  void _navigateToRecipePage(Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipePage(recipe: recipe),
      ),
    );
  }
}
