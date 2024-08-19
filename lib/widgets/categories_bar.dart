import 'dart:convert';
import 'package:cook_app/screens/category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class CategoryBar extends StatelessWidget {
  const CategoryBar({super.key});

  Future<List<dynamic>> _loadCategories() async {
    final String response =
        await rootBundle.loadString('assets/data/categories.json');
    final data = await json.decode(response);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _loadCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error loading categories');
        } else {
          final categories = snapshot.data!;
          return SizedBox(
            height: 50.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryPage(
                                  category: categories[index]['name'],
                                )),
                      );
                    },
                    child: Chip(
                      label: Text(categories[index]['name']),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
