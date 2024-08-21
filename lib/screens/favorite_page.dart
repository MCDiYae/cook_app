import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cook_app/models/recipe.dart';
import 'package:cook_app/screens/recipe_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late Future<List<Recipe>> favoriteRecipesFuture;

  @override
  void initState() {
    super.initState();
    favoriteRecipesFuture = _loadFavoriteRecipes();
  }

  Future<List<Recipe>> _loadFavoriteRecipes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoriteRecipeIds = prefs.getStringList('favoriteRecipes') ?? [];
      final allRecipes = await _fetchAllRecipes();

      return allRecipes
          .where((recipe) => favoriteRecipeIds.contains(recipe.id))
          .toList();
    } catch (e) {
      // Handle error
      return [];
    }
  }

  Future<List<Recipe>> _fetchAllRecipes() async {
    final String response =
        await rootBundle.loadString('assets/data/recipes.json');
    final List<dynamic> data = json.decode(response);

    return data.map<Recipe>((json) => Recipe.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Favorites Recipes")),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: favoriteRecipesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading recipes'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No favorite recipes'));
          } else {
            final favoriteRecipes = snapshot.data!;
            return ListView.builder(
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index) {
                final recipe = favoriteRecipes[index];
                return ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      recipe.imageUrl,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  title: Text(recipe.title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipePage(recipe: recipe),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
