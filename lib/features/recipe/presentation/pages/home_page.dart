import 'package:cook_app/features/ads/banner_ad.dart';
import 'package:cook_app/features/recipe/presentation/pages/favorite_page.dart';
import 'package:cook_app/features/recipe/presentation/widgets/category_bar.dart';
import 'package:cook_app/features/recipe/presentation/widgets/grid_recipes.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


import '../widgets/search_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   int _selectedIndex = 0;

  // List of pages to display
  final List<Widget> _pages = [
    const HomeContent(),
     const FavoritesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
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

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Padding(
      padding:  EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MySearchBar(),
            SizedBox(height: 20),
            CategoryBar(),
            SizedBox(height: 20),
            BannerInlinePage(adSize: AdSize.banner),
            SizedBox(height: 20),
            RecipesGrid(),
          ],
        ),
      ),
    );
  }
}
