import 'package:cook_app/utils/app_theme.dart';
import 'package:cook_app/screens/home_page.dart';
import 'package:cook_app/utils/favorite_service.dart';
import 'package:cook_app/utils/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
     await Hive.initFlutter();
     await Hive.openBox('favorites');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RecipeProviderSearch()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),

      ],
      child: const MyApp(),

    ),
    
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<RecipeProviderSearch>().loadRecipes();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "EazeeEats",
      theme: buildAppTheme(),
      home: const MyHomePage(),
    );
  }
}
