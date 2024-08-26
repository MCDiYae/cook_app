import 'package:flutter/material.dart';
import 'package:cook_app/models/recipe.dart';
import 'package:cook_app/screens/recipe_page.dart';
import 'package:cook_app/utils/search_provider.dart';
import 'package:cook_app/widgets/recipe_card.dart';
import 'package:provider/provider.dart';

class TrendRecipesGrid extends StatelessWidget {
  const TrendRecipesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProviderSearch>(context);
    final recipes = recipeProvider.filteredRecipes;
    final isSearching = recipeProvider.searchQuery.isNotEmpty;

    if (recipes.isEmpty) {
      return const Center(child: Text('No recipes found'));
    }

    final displayedRecipes = isSearching
        ? recipes.map((json) => Recipe.fromJson(json)).toList()
        : recipes
            .where((recipe) => recipe['categories'].contains('trend'))
            .map((json) => Recipe.fromJson(json))
            .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isSearching ? 'Search Results' : 'Popular Recipes',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: displayedRecipes.length,
          itemBuilder: (context, index) {
            final recipe = displayedRecipes[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipePage(
                      recipe: recipe,
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
      ],
    );
  }
}
