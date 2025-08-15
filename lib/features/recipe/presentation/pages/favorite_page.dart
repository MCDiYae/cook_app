import 'package:cook_app/features/recipe/data/models/recipe.dart';
import 'package:cook_app/features/recipe/presentation/pages/recipe_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit/favorite_cubit.dart';
import '../widgets/favorite_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes'),
      ),
      body: BlocBuilder<FavoritesCubit, List<Recipe>>(
        builder: (context, favorites) {
          if (favorites.isEmpty) {
            return const Center(child: Text('No favorite recipes yet.'));
          }
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final recipe = favorites[index];
              return FavoriteCard(
                recipe: recipe,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecipePage(recipe: recipe)),
                  );
                },
                onRemove: () {
                  context.read<FavoritesCubit>().removeFavorite(recipe.id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
