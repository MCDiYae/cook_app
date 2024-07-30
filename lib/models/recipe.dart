class Recipe {
  final String id;
  final String title;
  final String imageUrl;
  final List<String> categories;
  final List<String> ingredients;
  final List<String> steps;
  

  Recipe(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.categories,
      required this.ingredients,
      required this.steps});

  factory Recipe.fromJson(Map<String, dynamic> json, categories) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      categories: List<String>.from(json['categories']),
      ingredients: List<String>.from(json['ingredients']),
      steps: List<String>.from(json['steps']),
    );
  }
}
