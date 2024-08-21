import 'package:cook_app/models/recipe.dart';
import 'package:cook_app/utils/favorite_service.dart';
import 'package:cook_app/widgets/favorite_button.dart';
import 'package:flutter/material.dart';



class RecipePage extends StatefulWidget {
  final Recipe recipe;

  const RecipePage({super.key, required this.recipe});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  late Future<bool> _isFavoriteFuture;
  final FavoriteRecipeService _favoriteService = FavoriteRecipeService();

  @override
  void initState() {
    super.initState();
    _isFavoriteFuture = _favoriteService.isFavorite(widget.recipe.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRecipeImage(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRecipeTitle(),
                  const SizedBox(height: 16),
                  _buildIngredientsList(),
                  const SizedBox(height: 16),
                  _buildStepsList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: _buildBackButton(),
      actions: [_buildFavoriteButton()],
    );
  }

  Widget _buildBackButton() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Colors.yellow,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Colors.black,
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return FutureBuilder<bool>(
      future: _isFavoriteFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return FavoriteButton(
          isFavorite: snapshot.data ?? false,
          onPressed: _toggleFavorite,
        );
      },
    );
  }

  Future<void> _toggleFavorite() async {
    final isFavorite = await _favoriteService.toggleFavorite(widget.recipe.id);
    setState(() {
      _isFavoriteFuture = Future.value(isFavorite);
    });
  }

  Widget _buildRecipeImage() {
    return Image.asset(
      widget.recipe.imageUrl,
      width: double.infinity,
      height: 300,
      fit: BoxFit.cover,
    );
  }

  Widget _buildRecipeTitle() {
    return Center(
      child: Text(
        widget.recipe.title,
        style: Theme.of(context).textTheme.headlineLarge,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildIngredientsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredients',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        ...widget.recipe.ingredients.map(_buildIngredientItem),
      ],
    );
  }

  Widget _buildIngredientItem(String ingredient) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 4),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.yellow),
          const SizedBox(width: 8),
          Text(
            ingredient,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Steps',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        ...widget.recipe.steps.asMap().entries.map(_buildStepItem),
      ],
    );
  }

  Widget _buildStepItem(MapEntry<int, String> entry) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 4),
      child: Text(
        '${entry.key + 1}. ${entry.value}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}