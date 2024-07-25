import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon:const Icon(Icons.search),
          hintText: 'Search any recipe',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          ),
        ),
      
    );
  }
}
