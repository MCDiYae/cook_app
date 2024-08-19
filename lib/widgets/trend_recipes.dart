import 'dart:convert';
import 'package:cook_app/screens/recipe_page.dart';
import 'package:cook_app/widgets/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class TrendRecipesGrid extends StatelessWidget {
  const TrendRecipesGrid({super.key});

  Future<List<dynamic>> _loadRecipes() async {
    final String response =
        await rootBundle.loadString('assets/data/recipes.json');
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
          final trendRecipes = recipes
              .where((recipe) => recipe['categories'].contains('trend'))
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
                        title: recipe['title'],
                        imageUrl: recipe['imageUrl'],
                        ingredients: List<String>.from(recipe['ingredients']),
                        steps: List<String>.from(recipe['steps']),
                      ),
                    ),
                  );
                },
                child: RecipeCard(
                  title: trendRecipes[index]['title'],
                  imageUrl: trendRecipes[index]['imageUrl'],
                ),
              );
            },
          );
        }
      },
    );
  }
}
