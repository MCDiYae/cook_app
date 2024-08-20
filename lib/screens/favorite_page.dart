import 'package:cook_app/utils/favorite_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favoriteRecipeIds = favoritesProvider.favoriteRecipeIds;

    return ListView.builder(
      itemCount: favoriteRecipeIds.length,
      itemBuilder: (context, index) {
        final recipeId = favoriteRecipeIds[index];
        // Fetch the recipe details using the recipeId
        // For now, just display the recipeId
        return ListTile(
          title: Text('Recipe ID: $recipeId'),
          trailing: IconButton(
            icon: const Icon(Icons.remove_circle),
            onPressed: () {
              favoritesProvider.toggleFavoriteStatus(recipeId);
            },
          ),
        );
      },
    );
  }
}
