import 'package:cook_app/widgets/categories_bar.dart';
import 'package:cook_app/widgets/recipe_bar.dart';
import 'package:cook_app/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body:const Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search Bar
              MySearchBar(),
        
              // Category Bar
              CategoriesBar(),
        
              // Popular recipes Bar
              RecipesBar(),
            ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          items:const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favoris',
            ),
          ],
        ),
      ),
    );
  }
}
