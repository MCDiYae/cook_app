
import 'package:cook_app/features/recipe/data/models/recipe.dart';
import 'package:flutter/material.dart';

class FavoriteCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const FavoriteCard({super.key, 
    required this.recipe,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 4.0,
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              recipe.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(recipe.title),
          subtitle: Text('${recipe.ingredients.length} ingredients • ${recipe.steps.length} steps'),
          trailing: IconButton(
            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
            onPressed: onRemove,
          ),
        ),
      ),
    );
  }
}