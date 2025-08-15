import 'package:cook_app/features/recipe/data/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit/favorite_cubit.dart';




class RecipePage extends StatefulWidget {
  final Recipe recipe;
  const RecipePage({super.key, required this.recipe});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: _buildBackButton(),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.recipe.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
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

        floatingActionButton: BlocBuilder<FavoritesCubit, List<Recipe>>(
        builder: (context, favorites) {
          final isFavorite = favorites.any((r) => r.id == widget.recipe.id);
          return FloatingActionButton(
            onPressed: () {
              if (isFavorite) {
                context.read<FavoritesCubit>().removeFavorite(widget.recipe.id);
              } else {
                context.read<FavoritesCubit>().addFavorite(widget.recipe);
              }
            },
            child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          );
        },
      ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Colors.orange,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Colors.black,
        onPressed: () => Navigator.of(context).pop(),
      ),
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
          style: Theme.of(context).textTheme.titleMedium,
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
          const Icon(Icons.circle, size: 8, color: Colors.orange),
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
          style: Theme.of(context).textTheme.titleMedium,
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
