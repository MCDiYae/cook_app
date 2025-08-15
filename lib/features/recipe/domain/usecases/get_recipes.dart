
import 'package:cook_app/features/recipe/data/repositories/recipe_repository.dart';

import '../../data/models/recipe.dart';

class GetRecipes {
  final RecipeRepository repository;

  GetRecipes(this.repository);

  Future<List<Recipe>> call() async {
    return await repository.getRecipes();
  }
}