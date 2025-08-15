import 'package:cook_app/features/recipe/data/datasources/category_service.dart';
import 'package:cook_app/features/recipe/data/datasources/remote_data.dart';
import 'package:cook_app/features/recipe/data/repositories/category_repository_impl.dart';
import 'package:cook_app/features/recipe/data/repositories/recipe_repository.dart';
import 'package:cook_app/features/recipe/domain/usecases/get_categories.dart';
import 'package:cook_app/features/recipe/presentation/bloc/bloc_category/category_bloc.dart';
import 'package:cook_app/features/recipe/presentation/bloc/bloc_recipe/recipe_bloc.dart';
import 'package:cook_app/features/recipe/presentation/pages/home_page.dart';
import 'package:cook_app/utils/app_init.dart';
import 'package:cook_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'features/recipe/presentation/bloc/cubit/favorite_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: AppInit.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<RecipeBloc>(
                  create: (context) => RecipeBloc(
                      RecipeRepository(RecipeRemoteDataSource(http.Client())))
                    ..add(FetchTrendingRecipes()),
                ),
                BlocProvider<CategoryBloc>(
                  create: (context) => CategoryBloc(
                    GetCategories(
                      CategoryRepositoryImpl(
                          CategoryRemoteDataSource(http.Client())),
                    ),
                  )..add(FetchCategories()),
                ),
                BlocProvider<FavoritesCubit>(
                  create: (context) => FavoritesCubit()..loadFavorites(),
                ),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: "EazeeEats",
                theme: buildAppTheme(),
                home: const MyHomePage(),
              ),
            );
          }
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        });
  }
}
