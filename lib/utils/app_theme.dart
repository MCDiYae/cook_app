import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  return ThemeData(
    primaryColor: Colors.orange, // Updated primary color to orange
    scaffoldBackgroundColor: Colors.white, // Retain white for background
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.orange, // Use primary color for app bar
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white), // White icons for contrast
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20), // White text for contrast
    ),
    textTheme: const TextTheme(
      bodyLarge:
          TextStyle(color: Colors.brown, fontSize: 16), // Use brown for text
      bodyMedium: TextStyle(
          color: Colors.green, fontSize: 14), // Use green for secondary text
    ),
    iconTheme: const IconThemeData(color: Colors.red), // Use red for icons
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.orange, // Use primary color for selected items
      unselectedItemColor: Colors.grey, // Retain grey for unselected items
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white, // Use white for card background
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey[200],
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.green, // Use green for buttons
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
