import 'package:cook_app/features/recipe/presentation/widgets/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc_recipe/recipe_bloc.dart';
import '../pages/recipe_page.dart';

class RecipesGrid extends StatelessWidget {
  const RecipesGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 4 : 2;

    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        if (state is RecipeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RecipeLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(state.recipes.isEmpty ? "Search Results " : "Popular Recipes",
                style: Theme.of(context).textTheme.titleLarge,),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: state.recipes.length,
                itemBuilder: (BuildContext context, int index) {
                  final recipe = state.recipes[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipePage(recipe: recipe),
                        ),
                      );
                    },
                    child: RecipeCard(recipe: recipe),
                  );
                },
              ),
            ],
          );
        } else if (state is RecipeError) {
          return Center(child: Text(state.message));
        } else if (state is RecipeNoInternet) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('No internet connection'),
                ElevatedButton(
                  onPressed: () {
                    context.read<RecipeBloc>().add(FetchTrendingRecipes());
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
