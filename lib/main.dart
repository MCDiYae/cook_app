import 'package:cook_app/app_theme.dart';
import 'package:cook_app/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "EazeeEats",
      theme: buildAppTheme(),
      home: const MyHomePage(),
    );
  }
}
