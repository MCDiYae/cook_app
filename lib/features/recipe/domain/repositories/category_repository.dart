

import 'package:cook_app/features/recipe/data/models/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
}