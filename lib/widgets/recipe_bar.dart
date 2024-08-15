import 'dart:convert';
import 'package:cook_app/screens/recipe_page.dart';
import 'package:cook_app/widgets/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class RecipesBar extends StatelessWidget {
  const RecipesBar({super.key});

  Future<List<dynamic>> _loadRecipes() async {
    final String response = await rootBundle.loadString('assets/data/recipes.json');
    final data = await json.decode(response);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _loadRecipes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error loading recipes');
        } else {
          final recipes = snapshot.data!;
          return Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipePage(recipe: recipes[index]),
                      ),
                    );
                  },
                  child: RecipeCard(recipe: recipes[index]),
                );
              },
            ),
          );
        }
      },
    );
  }
}
