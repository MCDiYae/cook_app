import 'package:cook_app/models/recipe.dart';
import 'package:flutter/material.dart';


class RecipeListItem extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;

  const RecipeListItem({
    super.key,
    required this.recipe,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          recipe.imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        recipe.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        '${recipe.ingredients.length} ingredients • ${recipe.steps.length} steps',
        style: const TextStyle(fontSize: 12),
      ),
      onTap: onTap,
    );
  }
}