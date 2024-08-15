import 'package:cook_app/widgets/categories_bar.dart';
import 'package:cook_app/widgets/search_bar.dart';
import 'package:cook_app/widgets/trend_recipes.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MySearchBar(),
                SizedBox(height: 20),
                CategoryBar(),
                SizedBox(height: 20),
                Text(
                  'Popular Recipes',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TrendRecipesGrid()
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          items: const [
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
