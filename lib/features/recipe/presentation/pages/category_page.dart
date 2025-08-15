import 'package:cook_app/features/ads/banner_ad.dart';
import 'package:cook_app/features/recipe/presentation/pages/recipe_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../bloc/bloc_recipe/recipe_bloc.dart';
import '../widgets/recipe_card.dart';

class CategoryPage extends StatelessWidget {
  final String categoryName;

  const CategoryPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 4 : 2;
    context.read<RecipeBloc>().add(FetchRecipesByCategory(categoryName));

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(categoryName),
          leading: Container(
            margin: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<RecipeBloc>().add(FetchTrendingRecipes());
                }),
          ),
        ),
        body: BlocBuilder<RecipeBloc, RecipeState>(
          builder: (context, state) {
            if (state is RecipeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RecipesByCategoryLoaded) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: state.categorizedRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = state.categorizedRecipes[index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipePage(
                              recipe: recipe,
                            ),
                          ),
                        );
                      },
                      child:
                          RecipeCard(recipe: state.categorizedRecipes[index]));
                },
              );
            } else if (state is RecipeError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      
      bottomNavigationBar: const BannerInlinePage(adSize: AdSize.banner),
      ),
    );
  }
}
