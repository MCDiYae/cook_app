import 'package:flutter/material.dart';
import 'package:cook_app/models/recipe.dart'; // Importez votre modèle Recipe
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

    if (recipes.isEmpty) {
      return const Center(child: Text('No recipes found'));
    }

    final trendRecipes = recipes
        .where((recipe) => recipe['categories'].contains('trend'))
        .map((json) => Recipe.fromJson(json)) // Conversion JSON en Recipe
        .toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: trendRecipes.length,
      itemBuilder: (context, index) {
        final recipe = trendRecipes[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipePage(
                  recipe: recipe, // Passez l'objet Recipe ici
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
    );
  }
}
