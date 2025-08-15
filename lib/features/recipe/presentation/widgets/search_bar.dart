import 'package:cook_app/features/ads/interstitial_ad.dart';
import 'package:cook_app/features/recipe/presentation/bloc/bloc_recipe/recipe_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search any recipe',
                hintStyle: TextStyle(color: Colors.grey[500]),
                border: InputBorder.none,
              ),
              onChanged: (query) {
                if (query.isEmpty) {
                  context.read<RecipeBloc>().add(FetchTrendingRecipes());
                } else {
                  context.read<RecipeBloc>().add(SearchRecipes(query));
                }
              },
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus(); //close keyborad
                InterstitialAdManager.loadAd();
                InterstitialAdManager.showAd();
              },
              child: Icon(Icons.search, color: Colors.grey[600])),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
