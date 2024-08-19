import 'package:cook_app/screens/recipe_page.dart';
import 'package:cook_app/utils/search_provider.dart';
import 'package:cook_app/widgets/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProviderSearch>(context);
    final favoriteRecipes = recipeProvider.filteredRecipes;

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: favoriteRecipes.length,
        itemBuilder: (context, index) {
          final recipe = favoriteRecipes[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipePage(
                    title: recipe.title,
                    imageUrl: recipe.imageUrl,
                    ingredients: List<String>.from(recipe.ingredients),
                    steps: List<String>.from(recipe.steps),
                  ),
                ),
              );
            },
            child: RecipeCard(
              title: recipe.title,
              imageUrl: recipe.imageUrl,
            ),
          );
        },
      ),
    );
  }
}
