import 'dart:convert';
import 'package:cook_app/features/recipe/data/models/recipe.dart';
import 'package:http/http.dart' as http;


class RecipeRemoteDataSource {
  final http.Client client;

  RecipeRemoteDataSource(this.client);


  Future<List<Recipe>> fetchRecipes() async {
   // final uri = Uri.https('mcdiyae.github.io', '/api-eazee/recipes.json');
    final uri = Uri.https('recipe-api-express.onrender.com', '/api/recipes');

    return _getRecipesFromUri(uri);
  }

   Future<List<Recipe>> fetchTrendingRecipes() async {
    final uri = Uri.https('recipe-api-express.onrender.com', '/api/recipes', {'categories': 'trend'});
    return _getRecipesFromUri(uri);
  }

  

  Future<List<Recipe>> _getRecipesFromUri(Uri uri) async {
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to load recipes. Status code: ${response.statusCode}');
    }
  }
}