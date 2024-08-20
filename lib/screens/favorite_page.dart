import 'package:cook_app/utils/favorite_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    //final favoriteRecipeIds = favoritesProvider.favoriteRecipeIds;
    final favoriteRecipes = favoritesProvider.favoriteRecipes;

    if (favoriteRecipes.isEmpty) {
      return const Center(child: Text('No favorite recipes found'));
    }

    return ListView.builder(
      itemCount: favoriteRecipes.length,
      itemBuilder: (context, index) {
        final recipe = favoriteRecipes[index];

        return ListTile(
          leading: Image.asset(recipe.imageUrl, width: 50, height: 50),
          title: Text(recipe.title),
          trailing: IconButton(
            icon: const Icon(Icons.remove_circle),
            onPressed: () {
              favoritesProvider.toggleFavoriteStatus(recipe);
            },
          ),
          onTap: () {
            
          },
        );
      },
    );
  }
}
